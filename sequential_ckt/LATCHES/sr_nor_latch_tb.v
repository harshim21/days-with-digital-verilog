`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:06:27
// Design Name: 
// Module Name: sr_nor_latch_tb
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
module SR_nor_Latch_tb;

    // Declare testbench signals
    reg S, R;   // Inputs to SR latch
    wire Q, Qn; // Outputs from SR latch

    // Instantiate the SR_Latch module
    SR_NOR_Latch uut (
        .S(S),
        .R(R),
        .Q(Q),
        .Qn(Qn)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        S = 0; R = 0;
        #10; // Wait for 10 time units

        // Test case 1: Set the latch (S=1, R=0)
        S = 1; R = 0;
        #10;
        $display("S = %b, R = %b, Q = %b, Qn = %b", S, R, Q, Qn);

        // Test case 2: Reset the latch (S=0, R=1)
        S = 0; R = 1;
        #10;
        $display("S = %b, R = %b, Q = %b, Qn = %b", S, R, Q, Qn);

        // Test case 3: Invalid state (S=1, R=1) (This is not allowed in SR latch)
        S = 1; R = 1;
        #10;
        $display("S = %b, R = %b, Q = %b, Qn = %b", S, R, Q, Qn);

        // Test case 4: Set the latch again (S=1, R=0)
        S = 1; R = 0;
        #10;
        $display("S = %b, R = %b, Q = %b, Qn = %b", S, R, Q, Qn);

        // Test case 5: Reset the latch again (S=0, R=1)
        S = 0; R = 1;
        #10;
        $display("S = %b, R = %b, Q = %b, Qn = %b", S, R, Q, Qn);

        // Finish simulation
        $finish;
    end

endmodule
