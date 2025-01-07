`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 14:57:37
// Design Name: 
// Module Name: encoder
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
module encoder_4_to_2 (
    input wire [3:0] in,   // 4 input lines
    output wire [1:0] out  // 2 output lines
);

    assign out = (in[3] ? 2'b11 :
                  in[2] ? 2'b10 :
                  in[1] ? 2'b01 :
                  2'b00);

endmodule
