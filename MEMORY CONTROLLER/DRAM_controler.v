module dram_controller (
    input wire clk, reset,
    input wire req, rw,              // Read (1) / Write (0)
    input wire [15:0] addr,           // 16-bit Address
    inout wire [7:0] data,            // Bidirectional data bus
output reg mem_ce, mem_oe, mem_we, mem_ras, mem_cas, refresh  );    reg [7:0] data_reg;
      reg data_out_enable;
      assign data = (data_out_enable) ? data_reg : 8'bz;
 parameter  IDLE  = 3'b000, REFRESH = 3'b001, ACTIVATE = 3'b010, READ  = 3'b011, WRITE = 3'b100,PRECHARGE = 3'b101,DONE = 3'b110 ; 
reg [2:0] state;
 always @(posedge clk or posedge reset) begin
  if (reset) begin
   state <= IDLE;  refresh <= 0;  mem_ce <= 1; mem_ras <= 1; mem_cas <= 1;
            mem_oe <= 1; mem_we <= 1; data_out_enable <= 0;
        end else begin
case (state)
     IDLE: if (req) state<= (rw) ? READ : WRITE;
     REFRESH: begin   refresh <= 1;   state <= IDLE;
                          end
     ACTIVATE: begin  mem_ce <= 0;        mem_ras <= 0;
                                  state <= (rw) ? READ : WRITE;
                           end
     READ: begin mem_cas <= 0;   mem_oe <= 0;  mem_we <= 1;
                          state <= DONE;
                end
     WRITE: begin  mem_cas <= 0;             mem_we <= 0;
                             data_reg <= data;       data_out_enable <= 1;
                             state <= DONE;
                   end
    PRECHARGE: begin    mem_ce <=1;     mem_ras <= 1;
                                     state <= IDLE;
                         end
    DONE: begin     mem_ce <= 1;             mem_ras <= 1;   
              mem_cas <= 1;            mem_oe <= 1;       mem_we <= 1;
              data_out_enable <= 0;
              state <= IDLE;
        end
 endcase
        end     
    end
 endmodule

//testbench 
`timescale 1ns / 1ps

module dram_controller_tb;

    // Inputs to the DUT
    reg clk;
    reg reset;
    reg req;
    reg rw;
    reg [15:0] addr;

    // Bidirectional data
    wire [7:0] data;

    // Internal driver for data
    reg [7:0] data_in;        // Data to write
    reg data_drive;           // Control data direction
    wire [7:0] data_wire;     // Connection to DUT data line

    // Control outputs from the DUT
    wire mem_ce, mem_oe, mem_we, mem_ras, mem_cas, refresh;

    // Instantiate the DRAM controller
    dram_controller uut (
        .clk(clk),
        .reset(reset),
        .req(req),
        .rw(rw),
        .addr(addr),
        .data(data_wire),
        .mem_ce(mem_ce),
        .mem_oe(mem_oe),
        .mem_we(mem_we),
        .mem_ras(mem_ras),
        .mem_cas(mem_cas),
        .refresh(refresh)
    );

    // Drive the bidirectional data line
    assign data_wire = (data_drive) ? data_in : 8'bz;
    assign data = data_wire;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period => 100MHz clock
    end

    // Test sequence
    initial begin
        // Initial values
        reset = 1;
        req = 0;
        rw = 0;
        addr = 16'h0000;
        data_in = 8'h00;
        data_drive = 0;

        // Reset pulse
        #20;
        reset = 0;

        // ---------------------------------
        // WRITE Operation
        // ---------------------------------
        $display("---- Starting WRITE operation ----");
        @(posedge clk);

        addr = 16'h0010;      // Write to address 0x0010
        data_in = 8'hA5;      // Write data 0xA5
        data_drive = 1;       // Enable data driving (controller reads data)
        rw = 0;               // Write request
        req = 1;              // Assert request

        @(posedge clk);
        req = 0;              // Deassert request after one cycle

        // Wait for DONE state
        wait (uut.state == uut.DONE);
        @(posedge clk);
        data_drive = 0;       // Stop driving data after write completes

        $display("---- WRITE operation complete ----");
        #20;

        // ---------------------------------
        // READ Operation
        // ---------------------------------
        $display("---- Starting READ operation ----");
        @(posedge clk);

        addr = 16'h0010;      // Read from address 0x0010
        rw = 1;               // Read request
        req = 1;              // Assert request
        data_drive = 0;       // Tri-state (don't drive during read)

        @(posedge clk);
        req = 0;              // Deassert request after one cycle

        // Wait for DONE state
        wait (uut.state == uut.DONE);
        @(posedge clk);

        $display("---- READ operation complete ----");
        $display("Read Data = %h", data_wire);

        #20;

        // ---------------------------------
        // Refresh cycle wait
        // ---------------------------------
        $display("---- Waiting for REFRESH cycle ----");
        wait (refresh == 1);
        @(posedge clk);
        $display("Refresh triggered!");

        #100;

        $display("Testbench completed.");
        $stop;
    end

endmodule
