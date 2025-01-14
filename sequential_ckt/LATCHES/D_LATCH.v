`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:08:25
// Design Name: 
// Module Name: D_LATCH
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

module D_Latch (
    input D,    // Data input
    input C,    // Control (Clock) input
    output Q,   // Output
    output Qn   // Complement of output
);

    // Internal wire for the latch
    wire D_int;

    // NAND gates for D Latch (Level-sensitive)
    assign D_int = D & C;      // When control is active, pass data to latch
    assign Q = D_int | (~C & Q);  // When control is inactive, Q holds its value
    assign Qn = ~Q;             // Complement of Q

endmodule
