`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 15:47:35
// Design Name: 
// Module Name: testbench
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
module cdc_bist_tb_m;

    reg clk1;                  // Clock for source domain
    reg clk2;                  // Clock for destination domain
    reg rst;                   // Reset signal
    wire error_flag;           // Error flag from the BIST system
    wire [1:0] solution;       // Suggested solution for errors

    // Instantiate the top-level BIST system
    cdc_bist_top_more uut (
        .clk1(clk1),
        .clk2(clk2),
        .rst(rst),
        .error_flag(error_flag),
        .solution(solution)
    );

    // Clock generation
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
        // Apply reset
        rst = 1;
        #20 rst = 0; // Release reset after 20 time units
        
        // Run the simulation for a sufficient amount of time to test various scenarios
        #500;
        
        // End simulation
        $finish;
    end

    // Monitor simulation output
    initial begin
        $monitor("At time %0t, Error Flag = %b, Suggested Solution = %b", $time, error_flag, solution);
    end

endmodule

