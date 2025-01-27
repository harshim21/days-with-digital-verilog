`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:44:42
// Design Name: 
// Module Name: grey_tb
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
// Testbench for Gray Code Sequence Generator
module gray_code_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg enable;
    reg [3:0] num_bits;
    wire [15:0] gray_out;

    // Instantiate the Gray Code Generator module
    gray_code_generator uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .num_bits(num_bits),
        .gray_out(gray_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Testbench stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        enable = 0;
        num_bits = 4; // Set number of bits to 4

        // Reset the system
        #10 rst = 0;

        // Enable the generator
        #10 enable = 1;

        // Run for a few clock cycles
        #100;

        // Disable the generator
        enable = 0;

        // End simulation
        #20 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | Gray Code Output: %0h", $time, gray_out);
    end

endmodule