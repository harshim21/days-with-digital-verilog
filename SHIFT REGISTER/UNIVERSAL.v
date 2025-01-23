`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 11:02:39
// Design Name: 
// Module Name: UNIVERSAL
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

module UniversalShiftRegister (
    input clk,              // Clock signal
    input rst_n,            // Active-low reset
    input shift_left,       // Shift left control
    input shift_right,      // Shift right control
    input load,             // Load control
    input [3:0] parallel_in,// 4-bit parallel input
    output reg [3:0] q      // 4-bit parallel output
);
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        q <= 4'b0;  // Reset the shift register
    end else if (load) begin
        q <= parallel_in; // Load parallel data into register
    end else if (shift_left) begin
        q <= q << 1; // Shift left
    end else if (shift_right) begin
        q <= q >> 1; // Shift right
    end
end
endmodule
