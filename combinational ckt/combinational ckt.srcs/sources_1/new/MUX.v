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


module MUX(
    input [3:0] data,
    input [1:0] sel,
    output reg out
    );
    always@(*)
    begin
    case (sel) 
             2'b00: out = data [0]; // Select input 0     
             2'b01: out = data [1]; // Select input 1 
             2'b10: out = data [2]; // Select input 2 
             2'b11: out = data [3]; // Select input 3 
           default: out = 1'b0; // avoid latch
            
 endcase 
end
endmodule
