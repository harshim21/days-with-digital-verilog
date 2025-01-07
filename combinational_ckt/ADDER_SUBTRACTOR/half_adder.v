`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:14:02
// Design Name: 
// Module Name: half_adder
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
module half_adder (
    input wire a,    // First input
    input wire b,    // Second input
    output wire sum, // Sum output
    output wire cout // Carry output
);

    assign sum = a ^ b;  // Sum is the XOR of inputs
    assign cout = a & b; // Carry is the AND of inputs

endmodule
