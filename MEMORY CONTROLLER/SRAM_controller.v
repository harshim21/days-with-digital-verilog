
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2025 10:28:22
// Design Name: 
// Module Name: SRAM_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module sram_controller (
    input wire clk, reset,
    input wire req, rw,               // Read (1) / Write (0)
    input wire [15:0] addr,            // 16-bit Address
    inout wire [7:0] data,             // Bidirectional data bus
    output reg mem_ce, mem_oe, mem_we  // Control signals
); 
 reg [7:0] data_reg;   reg data_out_enable;
assign data = (data_out_enable) ? data_reg : 8'bz;
parameter
 IDLE  = 2'b00,READ  = 2'b01,WRITE = 2'b10,
                                    DONE  = 2'b11;     
reg [2:0] state;
 always @(posedge clk or posedge reset) begin
       if (reset) 
      begin
            state <= IDLE;  
           mem_ce <= 1;mem_oe <= 1;mem_we <= 1;
            data_out_enable <= 0;
        end 
else
 begin
 case (state)
    IDLE: if (req) state <= (rw) ? READ : WRITE;
    READ: begin 
                   mem_ce <= 0; mem_oe <= 0; mem_we <= 1;
                   state <= DONE;
                  end
    WRITE: begin      
                   mem_ce <= 0; mem_oe <= 1; mem_we <= 0;
                   data_reg <= data;
                   data_out_enable <= 1;
                   state <= DONE;
                  end
  DONE: begin     
                 mem_ce <= 1; mem_oe <= 1; mem_we <= 1;
                 data_out_enable <= 0;
                 state <= IDLE;
                 end
            endcase
        end   end
endmodule



//testbench

`timescale 1ns / 1ps

module sram_controller_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg req;
    reg rw;
    reg [15:0] addr;
    wire [7:0] data;

    reg [7:0] data_in;        // To drive data during write
    wire [7:0] data_out;      // To capture data during read

    wire mem_ce, mem_oe, mem_we;

    // Data bus direction control
    assign data = (rw == 0 && req) ? data_in : 8'bz;
    assign data_out = data;

    // Instantiate SRAM Controller
    sram_controller uut (
        .clk(clk),
        .reset(reset),
        .req(req),
        .rw(rw),
        .addr(addr),
        .data(data),
        .mem_ce(mem_ce),
        .mem_oe(mem_oe),
        .mem_we(mem_we)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period clock
    end

    // Stimulus
    initial begin
        $display("******** SRAM Controller Testbench ********");
        reset = 1; req = 0; rw = 0; addr = 16'b0; data_in = 8'b0;
        #20;

        reset = 0;
        #10;

        // Write operation
        addr = 16'h00AA;
        data_in = 8'h55;
        rw = 0; // Write
        req = 1;
        #10;    // One clock cycle
        req = 0;
        #40;

        // Read operation
        addr = 16'h00AA;
        rw = 1; // Read
        req = 1;
        #10;
        req = 0;
        #40;

        // Another Write
        addr = 16'h00BB;
        data_in = 8'hA5;
        rw = 0; // Write
        req = 1;
        #10;
        req = 0;
        #40;

        // Another Read
        addr = 16'h00BB;
        rw = 1; // Read
        req = 1;
        #10;
        req = 0;
        #40;

        $display("******** Testbench Completed ********");
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0d | clk=%b | rst=%b | req=%b | rw=%b | addr=%h | data=%h | mem_ce=%b mem_oe=%b mem_we=%b",
                 $time, clk, reset, req, rw, addr, data_out, mem_ce, mem_oe, mem_we);
    end

endmodule

