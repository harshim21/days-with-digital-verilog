`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:10:33
// Design Name: 
// Module Name: JK_LATCH
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
module JK_Latch (
    input J,    // J input
    input K,    // K input
    input C,    // Clock input (Level-sensitive)
    output Q,   // Output
    output Qn   // Complement of output
);

    // Internal signals
    wire J_int, K_int, Q_int;

    // Logic for JK latch using NAND gates
    nand (J_int, J, C);        // Active J when C is high
    nand (K_int, K, C);        // Active K when C is high

    nand (Q_int, J_int, Qn);   // Set condition when J = 1
    nand (Qn, K_int, Q);       // Reset condition when K = 1

    assign Q = Q_int;          // Output Q
    assign Qn = ~Q;            // Complement of Q

endmodule
