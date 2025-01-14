`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:52:46
// Design Name: 
// Module Name: D_FF
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
module D_FlipFlop (
    input D,    // Data input
    input clk,  // Clock input
    output reg Q, // Output
    output Qn   // Complement of output
);

    assign Qn = ~Q;

    always @(posedge clk) begin
        Q <= D; // On clock edge, output takes the value of D
    end

endmodule
