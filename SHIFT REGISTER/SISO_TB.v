`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 11:12:47
// Design Name: 
// Module Name: SISO_TB
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
module SISO_tb;

    // Parameters
    parameter WIDTH = 4; // Width of the shift register

    // Testbench signals
    reg clk;
    reg rst;
    reg serial_in;
    wire serial_out;

    // Instantiate the SISO module
    SISO #(WIDTH) uut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
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
        rst = 1;        // Apply reset
        serial_in = 0;  // Initialize serial input

        // Apply reset and release it
        #10 rst = 0;    // Deassert reset

        // Test case 1: Shift a sequence of bits
        #10 serial_in = 1; // Input bit 1
        #10 serial_in = 0; // Input bit 0
        #10 serial_in = 1; // Input bit 1
        #10 serial_in = 1; // Input bit 1
        #40;               // Wait for additional clock cycles

        // Test case 2: Apply reset during operation
        #10 rst = 1;       // Assert reset
        #10 rst = 0;       // Deassert reset

        // Test case 3: Shift a new sequence of bits
        #10 serial_in = 0; // Input bit 0
        #10 serial_in = 1; // Input bit 1
        #10 serial_in = 1; // Input bit 1
        #10 serial_in = 0; // Input bit 0
        #40;

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | clk: %b | rst: %b | serial_in: %b | serial_out: %b | shift_reg: %b",
                 $time, clk, rst, serial_in, serial_out, uut.shift_reg);
    end

endmodule
