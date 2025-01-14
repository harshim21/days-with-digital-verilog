`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:56:03
// Design Name: 
// Module Name: T_FF
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

module T_FlipFlop (
    input T,    // T input
    input clk,  // Clock input
    output reg Q, // Output
    output Qn   // Complement of output
);

    assign Qn = ~Q;

    always @(posedge clk) begin
        if (T)
            Q <= ~Q;  // Toggle when T=1
        else
            Q <= Q;   // Hold when T=0
    end

endmodule
