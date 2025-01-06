`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2025 14:20:15
// Design Name: 
// Module Name: MUX
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
//GATE_LEVEL_MODELING
module MUX_21(              
    input [1:0] data,
    input  sel,
    output out
    );
    wire T1, T2, Sbar;
    and (T1, data[1], sel);
    and (T2, data[0], Sbar);
   not (Sbar, sel);
   or (out, T1, T2);
endmodule
