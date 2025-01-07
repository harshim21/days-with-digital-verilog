`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 14:48:32
// Design Name: 
// Module Name: demux4_16
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

   module demux_4_to_16 (
    input wire [3:0] sel,  // 4-bit select lines
    input wire in,         // Input
    output reg [15:0] y    // 16 outputs
);

    always @(*) begin
        case (sel)
            4'b0000: y = 16'b0000000000000001 & {16{in}};
            4'b0001: y = 16'b0000000000000010 & {16{in}};
            4'b0010: y = 16'b0000000000000100 & {16{in}};
            4'b0011: y = 16'b0000000000001000 & {16{in}};
            4'b0100: y = 16'b0000000000010000 & {16{in}};
            4'b0101: y = 16'b0000000000100000 & {16{in}};
            4'b0110: y = 16'b0000000001000000 & {16{in}};
            4'b0111: y = 16'b0000000010000000 & {16{in}};
            4'b1000: y = 16'b0000000100000000 & {16{in}};
            4'b1001: y = 16'b0000001000000000 & {16{in}};
            4'b1010: y = 16'b0000010000000000 & {16{in}};
            4'b1011: y = 16'b0000100000000000 & {16{in}};
            4'b1100: y = 16'b0001000000000000 & {16{in}};
            4'b1101: y = 16'b0010000000000000 & {16{in}};
            4'b1110: y = 16'b0100000000000000 & {16{in}};
            4'b1111: y = 16'b1000000000000000 & {16{in}};
            default: y = 16'b0000000000000000;  // Default case
        endcase
    end

endmodule 