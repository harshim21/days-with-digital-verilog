`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 15:44:08
// Design Name: 
// Module Name: test_top
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
module cdc_bist_top_more (
    input wire clk1,               // Clock for source domain (clk1)
    input wire clk2,               // Clock for destination domain (clk2)
    input wire rst,                // Reset signal
    output wire error_flag,        // Error flag (1 if error, 0 if no error)
    output wire [1:0] solution     // Solution suggestion based on error
);

    // Internal signals
    wire [7:0] data_from_clk1;
    wire [7:0] data_to_clk2;
    wire [1:0] error_type;         // Error type (00: no error, 01: metastability, 10: missed transfer, 11: data corruption)

    // Instantiate Data Generator (LFSR)
    data_generator data_gen (
        .clk1(clk1),
        .rst(rst),
        .data_out(data_from_clk1)
    );

    // Instantiate Data Transfer without Synchronization (original design)
    data_transfer transfer (
        .clk1(clk1),
        .clk2(clk2),
        .rst(rst),
        .data_in(data_from_clk1),
        .data_out(data_to_clk2)
    );

    // Instantiate CDC Error Detection
    cdc_error_detection_m error_detection (
        .clk2(clk2),
        .rst(rst),
        .test_signal(data_from_clk1),   // Data from clk1
        .synced_signal(data_to_clk2),   // Data in clk2 (received)
        .error_flag(error_flag),
        .error_type(error_type)
    );

    // Instantiate Solution Handler based on detected error
    solution_handler_m sol_handler (
        .clk1(clk1),
        .clk2(clk2),
        .rst(rst),
        .error_type(error_type),
        .data_in(data_from_clk1),
        .data_out(data_to_clk2)
    );

endmodule
