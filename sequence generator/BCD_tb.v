`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:53:11
// Design Name: 
// Module Name: BCD_tb
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

// Testbench for BCD Counter
module bcd_counter_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg enable;
    wire [3:0] bcd_out;

    // Instantiate the BCD Counter module
    bcd_counter uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .bcd_out(bcd_out)
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

        // Reset the system
        #10 rst = 0;

        // Enable the counter
        #10 enable = 1;

        // Run for a few clock cycles
        #100;

        // Disable the counter
        enable = 0;

        // End simulation
        #20 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | BCD Output: %0b", $time, bcd_out);
    end

endmodule
