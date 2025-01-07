`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:21:05
// Design Name: 
// Module Name: MV
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
module majority_voter (
    input wire a,    // First input
    input wire b,    // Second input
    input wire c,    // Third input
    output wire out  // Output
);

    assign out = (a & b) | (b & c) | (c & a);  // Majority function

endmodule
