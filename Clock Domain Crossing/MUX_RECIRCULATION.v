`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2025 14:42:41
// Design Name: 
// Module Name: MUX_RECIRCULATION
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
// MUX Recirculation Synchronizer
module mux_recirculation_synchronizer (
    input wire clk_src,                  // Source clock domain                              
    input wire clk_dest,                 // Destination clock domain
    input wire [1:0] data_in,     // 2-bit input data from source
    input wire en,                       // Enable signal from source
    output reg [1:0] data_out   // Output synchronization 
);
    reg en_sync1, en_sync2;  // Multi-flop sync. for EN
    wire en_sync;                        // Synchronized enable signal
    assign en_sync = en_sync2; // Final synchronized enable
    reg [1:0] data_ff;        // Flip-flop to hold synchronized data

    always @(posedge clk_dest) begin
        en_sync1 <= en;        // First stage of EN synchronization
        en_sync2 <= en_sync1;   // Second stage of EN sync.
    end

    always @(posedge clk_dest) begin
        if (en_sync)            // When enable signal is synchronized
            data_ff <= data_in;  // Capture the data from the source
        else
            data_ff <= data_ff;  // Retain previous data
        data_out <= data_ff;     // Update the synchronized output
    end
endmodule

// Testbench for MUX Recirculation Synchronizer
module tb_mux_recirculation_synchronizer;
    reg clk_src, clk_dest;
    reg [1:0] data_in;
    reg en;
    wire [1:0] data_out;
    
    // Instantiate the module
    mux_recirculation_synchronizer uut (
        .clk_src(clk_src),
        .clk_dest(clk_dest),
        .data_in(data_in),
        .en(en),
        .data_out(data_out)
    );
    
    // Clock generation
    always #5 clk_src = ~clk_src;
    always #7 clk_dest = ~clk_dest;
    
    initial begin
        // Initialize signals
        clk_src = 0;
        clk_dest = 0;
        en = 0;
        data_in = 2'b00;
        
        // Test sequence
        #10 en = 1; data_in = 2'b10;
        #20 en = 0;
        #30 en = 1; data_in = 2'b01;
        #40 en = 0;
        #50 en = 1; data_in = 2'b11;
        #60 en = 0;
        #70 $stop;
    end
endmodule
