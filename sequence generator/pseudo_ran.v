`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:49:42
// Design Name: 
// Module Name: pseudo_ran
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
// Testbench for Pseudo-Random Sequence Generator
module pseudo_random_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg enable;
    reg [3:0] seed;
    wire [3:0] prbs_out;

    // Instantiate the Pseudo-Random Generator module
    pseudo_random_generator uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .seed(seed),
        .prbs_out(prbs_out)
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
        seed = 4'b1010; // Set seed value

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
        $monitor("Time: %0t | PRBS Output: %0b", $time, prbs_out);
    end

endmodule
