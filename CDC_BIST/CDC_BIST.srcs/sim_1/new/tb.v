`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 12:54:44
// Design Name: 
// Module Name: tb
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
module cdc_bist_tb;

    // Clock and reset signals
    reg clk1;               // Source clock (clk1)
    reg clk2;               // Destination clock (clk2)
    reg rst;                // Reset signal

    // Output signals from the design under test (DUT)
    wire error_flag;        // Error flag from the CDC BIST system
    wire [255:0] solution;  // Suggested solution for detected errors

    // Instantiate the CDC BIST top module
    cdc_bist_top uut (
        .clk1(clk1),
        .clk2(clk2),
        .rst(rst),
        .error_flag(error_flag),
        .solution(solution)
    );

    // Clock generation for clk1 and clk2
    initial begin
        clk1 = 0;
        forever #5 clk1 = ~clk1; // Generate clk1 with a period of 10 time units
    end

    initial begin
        clk2 = 0;
        forever #7 clk2 = ~clk2; // Generate clk2 with a period of 14 time units (different frequency)
    end

    // Stimulus generation (reset and signal application)
    initial begin
        // Apply reset for a sufficient time to initialize the DUT
        rst = 1;
        #20 rst = 0; // Release reset after 20 time units
        
        // Monitor the simulation output
        $monitor("At time %0t, Error Flag = %b, Solution = %s", $time, error_flag, solution);
          
        // Run the simulation for a sufficient amount of time to test various scenarios
        #500;

        // End the simulation
        $finish;
    end

endmodule
