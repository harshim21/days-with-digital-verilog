`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.01.2025 16:28:31
// Design Name: 
// Module Name: mux8_1
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


module mux8_1(
    input [7:0] d,
    input [2:0] sel,
    output reg out
    );
   always@(*)
   begin
    if(sel==3'b000)
    out=d[0];
    else if(sel==3'b001)
    out=d[1]; 
    else if(sel==3'b010)
    out=d[2]; 
    else if(sel==3'b011)
    out=d[3]; 
    else if(sel==3'b100)
    out=d[4]; 
    else if(sel==3'b101)
    out=d[5]; 
    else if(sel==3'b110)
    out=d[6]; 
    else if(sel==3'b111)
    out=d[7]; 
    else 
    out=1'bx;
    end
endmodule
