`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.01.2025 16:41:35
// Design Name: 
// Module Name: mux_16_1
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


module mux_16_1(
    input [15:0] d,
    input [3:0] sel,
    output reg out
    );
    always@(*)
    begin
     case(sel)
     0000:out=d[0];
     0001:out=d[1];
     0010:out=d[2];
     0011:out=d[3];
     0010:out=d[4];
     0101:out=d[5];
     0110:out=d[6];
     0111:out=d[7];
     1000:out=d[8];
     1001:out=d[9];
     1010:out=d[10];
     1011:out=d[11];
     1100:out=d[12];
     1101:out=d[13];
     1110:out=d[14];
     1111:out=d[15];
     
     endcase
   end
     
endmodule
