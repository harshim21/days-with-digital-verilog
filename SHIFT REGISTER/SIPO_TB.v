`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 11:07:27
// Design Name: 
// Module Name: SIPO_TB
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
module SIPO_tb;

    // Parameters
    parameter WIDTH = 4; // Width of the shift register

    // Testbench signals
    reg clk;
    reg rst;
    reg serial_in;
    wire [WIDTH-1:0] parallel_out;

    // Instantiate the SIPO module
    SIPO #(WIDTH) uut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
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
        rst = 0;
        serial_in = 0;

        // Apply asynchronous reset
        #10 rst = 1; // Activate reset
        #10 rst = 0; // Deactivate reset

        // Serial input sequence
        #10 serial_in = 1; // Input bit 1
        #10 serial_in = 0; // Input bit 0
        #10 serial_in = 1; // Input bit 1
        #10 serial_in = 1; // Input bit 1

        // Wait to observe the final output
        #20;

        // Apply reset again to observe reset behavior
        rst = 1;
        #10 rst = 0;

        // Provide a new serial input sequence
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;
        #10 serial_in = 0;

        // End simulation
        #20 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | clk: %b | rst: %b | serial_in: %b | parallel_out: %b",
                 $time, clk, rst, serial_in, parallel_out);
    end

endmodule
