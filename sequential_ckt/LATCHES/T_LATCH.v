`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:12:56
// Design Name: 
// Module Name: T_LATCH
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
module T_Latch (
    input T,    // T input
    input C,    // Clock input (Level-sensitive)
    output Q,   // Output
    output Qn   // Complement of output
);

    // Internal signals for T latch
    wire T_int, Q_int;

    // Logic for T latch using NAND gates
    nand (T_int, T, C);           // Active T when C is high
    nand (Q_int, T_int, Qn);      // Toggle when T = 1
    nand (Qn, T_int, Q);          // Complementary output for Q

    assign Q = Q_int;             // Output Q
    assign Qn = ~Q;               // Complement of Q

endmodule
