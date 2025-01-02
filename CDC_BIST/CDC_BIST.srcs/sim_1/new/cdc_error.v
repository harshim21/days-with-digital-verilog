`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 15:42:12
// Design Name: 
// Module Name: cdc_error
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
module cdc_error_detection_m (
    input wire clk2,           // Clock for destination domain
    input wire rst,            // Reset signal
    input wire [7:0] test_signal, // Signal from clk1 (original data)
    input wire [7:0] synced_signal, // Signal received in clk2
    output reg error_flag,     // Error flag (1 if error, 0 if no error)
    output reg [1:0] error_type // Error type (01: metastability, 10: missed transfer, 11: data corruption)
);

    always @(posedge clk2 or posedge rst) begin
        if (rst) begin
            error_flag <= 0;
            error_type <= 2'b00; // No error
            
        end else begin
            // Metastability Detection (synced_signal = 'x')
            if (synced_signal === 8'bx) begin
                error_flag <= 1;
                error_type <= 2'b01; // Metastability error
            end
            // Missed Transfer Detection
            else if (test_signal !== synced_signal) begin
                error_flag <= 1;
                error_type <= 2'b10; // Missed transfer error
            end
            // Data Corruption Detection
            else if (test_signal != synced_signal) begin
                error_flag <= 1;
                error_type <= 2'b11; // Data corruption error
            end
            // No error detected
            else begin
                error_flag <= 0;
                error_type <= 2'b00; // No error
            end
        end
    end
endmodule

