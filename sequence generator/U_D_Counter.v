`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 16:03:39
// Design Name: 
// Module Name: U_D_Counter
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
// Testbench for Up-Down Counter
module up_down_counter_tb;

    // Parameter for the number of bits
    parameter N = 4;

    // Testbench signals
    reg clk;
    reg rst;
    reg enable;
    reg up_down;
    wire [N-1:0] count;

    // Instantiate the Up-Down Counter module
    up_down_counter #(N) uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .up_down(up_down),
        .count(count)
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
        up_down = 1; // Start with counting up

        // Reset the system
        #10 rst = 0;

        // Enable the counter
        #10 enable = 1;

        // Count up for a few cycles
        #100;

        // Switch to counting down
        up_down = 0;

        // Count down for a few cycles
        #100;

        // Disable the counter
        enable = 0;

        // End simulation
        #20 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | Up_Down: %0b | Count: %0b", $time, up_down, count);
    end

endmodule
