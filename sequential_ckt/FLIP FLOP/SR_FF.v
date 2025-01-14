`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:50:49
// Design Name: 
// Module Name: SR_FF
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

module SR_FlipFlop (
    input S,     // Set input
    input R,     // Reset input
    input clk,   // Clock input
    output reg Q,   // Output
    output Qn    // Complement of output
);

    assign Qn = ~Q;

    always @(posedge clk) begin
        if (S & ~R) Q <= 1;        // Set
        else if (~S & R) Q <= 0;   // Reset
        else if (~S & ~R) Q <= Q;  // Hold
        else Q <= 1'bx;            // Invalid (S=1, R=1)
    end

endmodule

