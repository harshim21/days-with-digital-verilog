`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:28:40
// Design Name: 
// Module Name: parity generator
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
module parity_generator (
    input wire [3:0] data, // 4 input data bits
    output wire parity     // Parity bit output
);

    assign parity = data[0] ^ data[1] ^ data[2] ^ data[3]; // XOR all input bits to generate parity

endmodule
