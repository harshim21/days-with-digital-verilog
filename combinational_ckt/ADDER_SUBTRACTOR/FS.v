`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:19:23
// Design Name: 
// Module Name: FS
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
module full_subtractor (
    input wire a,    // Minuend
    input wire b,    // Subtrahend
    input wire bin,  // Borrow in
    output wire diff, // Difference output
    output wire bout // Borrow out
);

    assign diff = a ^ b ^ bin;                  // Difference is the XOR of inputs and borrow-in
    assign bout = (~a & (b ^ bin)) | (b & bin); // Borrow-out is the OR of the ANDs

endmodule
