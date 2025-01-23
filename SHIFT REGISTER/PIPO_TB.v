`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 11:06:19
// Design Name: 
// Module Name: PIPO_TB
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
module PIPO_tb;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg load;
    reg [7:0] parallel_in;
    wire [7:0] parallel_out;

    // Instantiate the PIPO module
    PIPO uut (
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10-time unit clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst_n = 0;
        load = 0;
        parallel_in = 8'b0;

        #10 rst_n = 1;  // Deassert reset
        #10 load = 1;   // Load parallel data
        parallel_in = 8'b10101010;
        #10 load = 0;   // Stop loading, hold the value
        #20;            // Wait to observe the output

        // Test case 2: Load another value
        load = 1;
        parallel_in = 8'b11001100;
        #10 load = 0;   // Hold the value
        #20;

        // Test case 3: Apply reset
        rst_n = 0;      // Reset the module
        #10 rst_n = 1;  // Deassert reset
        #10;

        // Test case 4: Load a new value after reset
        load = 1;
        parallel_in = 8'b11110000;
        #10 load = 0;
        #20;

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | clk: %b | rst_n: %b | load: %b | parallel_in: %b | parallel_out: %b",
                 $time, clk, rst_n, load, parallel_in, parallel_out);
    end

endmodule
