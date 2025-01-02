`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 12:42:57
// Design Name: 
// Module Name: CDC_BIST
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
module cdc_bist_top (
    input wire clk1,           // Source clock (clk1)
    input wire clk2,           // Destination clock (clk2)
    input wire rst,            // Reset signal
    output wire error_flag,    // Error flag (1 if error, 0 if no error)
    output wire [255:0] solution // Suggested solution for detected CDC issue
);

    wire [3:0] lfsr_pattern;   // 4-bit LFSR pattern
    wire synced_signal;        // Synchronized signal in clk2
    wire [1:0] error_type;     // Error type (metastability, missed transfer, or corruption)

    // Instantiate the LFSR-based pattern generator
    lfsr_pattern_generator lfsr_inst (
        .clk(clk1),
        .rst(rst),
        .lfsr_out(lfsr_pattern)
    );

    // Instantiate the synchronizer to transfer the LFSR pattern from clk1 to clk2
    sync2 sync_inst (
        .clk(clk2),
        .rst(rst),
        .src(lfsr_pattern[0]), // Use the LSB or entire pattern (depending on your test design)
        .synced(synced_signal)
    );

    // Instantiate the error detection logic
    cdc_error_detection error_inst (
        .clk2(clk2),
        .rst(rst),
        .test_signal(lfsr_pattern[0]),  // Using the LSB for comparison
        .synced_signal(synced_signal),
        .error_flag(error_flag),
        .error_type(error_type)
    );

    // Instantiate the solution handler to provide solutions based on error type
    solution_handler solution_inst (
        .error_type(error_type),
        .solution(solution)
    );

endmodule
