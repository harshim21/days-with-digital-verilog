`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:32:19
// Design Name: 
// Module Name: CLA_ADDER
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

module cla_adder (
    input wire [3:0] a,    // First 4-bit input
    input wire [3:0] b,    // Second 4-bit input
    input wire cin,        // Carry input
    output wire [3:0] sum, // 4-bit sum output
    output wire cout       // Carry output
);

    wire [3:0] p, g; // Propagate and generate
    wire [4:0] c;    // Carry

    assign p = a ^ b;        // Propagate
    assign g = a & b;        // Generate
    assign c[0] = cin;       // Initial carry

    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & c[1]);
    assign c[3] = g[2] | (p[2] & c[2]);
    assign c[4] = g[3] | (p[3] & c[3]);

    assign sum = p ^ c[3:0]; // Sum
    assign cout = c[4];      // Carry out

endmodule
