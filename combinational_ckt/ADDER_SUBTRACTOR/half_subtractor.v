`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:17:51
// Design Name: 
// Module Name: half_subtractor
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
module half_subtractor (
    input wire a,    // Minuend
    input wire b,    // Subtrahend
    output wire diff, // Difference output
    output wire borrow // Borrow output
);

    assign diff = a ^ b;     // Difference is the XOR of inputs
    assign borrow = ~a & b;  // Borrow is the AND of NOT a and b

endmodule


