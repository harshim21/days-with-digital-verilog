`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 12:52:05
// Design Name: 
// Module Name: jofdm
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
module solution_handler_m (
    input wire clk1,                // Clock for source domain
    input wire clk2,                // Clock for destination domain
    input wire rst,                 // Reset signal
    input wire [1:0] error_type,    // Error type detected (00: no error, 01: metastability, 10: missed transfer, 11: data corruption)
    input wire [7:0] data_in,       // Data input from clk1
    output wire [7:0] data_out      // Data output to clk2 (after applying solution)
);

    wire [7:0] synced_signal;       // Signal from synchronizer (if metastability)
    wire [7:0] fifo_data_out;       // Data from FIFO (if missed transfer or data corruption)

    // 2-Stage Synchronizer for metastability (if error_type == 2'b01)
    sync2_m synchronizer (
        .clk(clk2),
        .rst(rst),
        .src(data_in),
        .synced(synced_signal)
    );

    // FIFO for missed transfers or data corruption (if error_type == 2'b10 or 2'b11)
    fifo #(
        .WIDTH(8),
        .DEPTH(16)
    ) fifo_buffer (
        .clk_write(clk1),
        .clk_read(clk2),
        .rst(rst),
        .data_in(data_in),
        .data_out(fifo_data_out),
        .fifo_empty(),
        .fifo_full()
    );

    // Solution logic: Apply the appropriate solution based on the detected error type
    assign data_out = (error_type == 2'b01) ? synced_signal : // Metastability -> Use synchronizer
                      (error_type == 2'b10 || error_type == 2'b11) ? fifo_data_out : // Missed transfer or data corruption -> Use FIFO
                      data_in; // No error -> Direct pass-through

endmodule

