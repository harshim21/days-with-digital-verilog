`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 11:00:49
// Design Name: 
// Module Name: PIPO
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
module PIPO (
    input clk,              // Clock signal
    input rst_n,            // Active-low reset
    input load,             // Load signal (to load parallel data)
    input [7:0] parallel_in,// 8-bit parallel input
    output reg [7:0] parallel_out // 8-bit parallel output
);reg [7:0] shift_reg;       // 8-bit shift register
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        shift_reg <= 8'b0;  // Reset the shift register
        parallel_out <= 8'b0; // Reset parallel output
    end else if (load) begin
        shift_reg <= parallel_in; // Load parallel data
    end else begin
        parallel_out <= shift_reg; 
    end
end
endmodule


