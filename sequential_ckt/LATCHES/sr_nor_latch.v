`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:05:14
// Design Name: 
// Module Name: sr_nor_latch
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

module SR_NOR_Latch (
    input S,    // Set input
    input R,    // Reset input
    output Q,   // Output
    output Qn   // Complement of output
);

    // Internal signals for NOR gates
    wire nS, nR;

    // NOR gates for SR latch
    nor (nS, S, Qn);
    nor (nR, R, Q);

    assign Q = nS;
    assign Qn = nR;

endmodule
