`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:16:04
// Design Name: 
// Module Name: full adder
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
module full_adder (
    input wire a,    // First input
    input wire b,    // Second input
    input wire cin,  // Carry input
    output wire sum, // Sum output
    output wire cout // Carry output
);

    assign sum = a ^ b ^ cin;       // Sum is the XOR of inputs and carry-in
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry-out is the OR of the ANDs

endmodule
