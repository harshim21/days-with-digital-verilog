`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 11:08:33
// Design Name: 
// Module Name: PISO_TB
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

module PISO_tb;

    // Testbench signals
    reg clk;
    reg rst_n;
    reg load;
    reg [7:0] parallel_in;
    wire serial_out;

    // Instantiate the PISO module
    PISO uut (
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .parallel_in(parallel_in),
        .serial_out(serial_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10-time unit clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst_n = 0;       // Apply reset
        load = 0;
        parallel_in = 8'b0;

        // Apply reset
        #10 rst_n = 1;  // Deassert reset

        // Test case 1: Load and shift
        #10 load = 1;   // Load parallel data
        parallel_in = 8'b10101010; 
        #10 load = 0;   // Deassert load to start shifting
        #80;            // Wait for 8 clock cycles to observe the full shift

        // Test case 2: Load another value and shift
        #10 load = 1;
        parallel_in = 8'b11001100;
        #10 load = 0;
        #80;

        // Test case 3: Apply reset during operation
        #20 rst_n = 0;  // Assert reset
        #10 rst_n = 1;  // Deassert reset

        // Test case 4: Load a new value after reset
        load = 1;
        parallel_in = 8'b11110000;
        #10 load = 0;
        #80;

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | clk: %b | rst_n: %b | load: %b | parallel_in: %b | serial_out: %b",
                 $time, clk, rst_n, load, parallel_in, serial_out);
    end

endmodule
