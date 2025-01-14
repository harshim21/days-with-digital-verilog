`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:13:48
// Design Name: 
// Module Name: T_LATCH_TB
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
module T_Latch_tb;

    // Declare testbench signals
    reg T, C;   // Inputs to T latch
    wire Q, Qn; // Outputs from T latch

    // Instantiate the T_Latch module
    T_Latch uut (
        .T(T),
        .C(C),
        .Q(Q),
        .Qn(Qn)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        T = 0; C = 0;
        #10; // Wait for 10 time units

        // Test case 1: T=1, C=1 (Toggle operation)
        T = 1; C = 1;
        #10;
        $display("T = %b, C = %b, Q = %b, Qn = %b", T, C, Q, Qn);

        // Test case 2: T=0, C=1 (Hold previous state)
        T = 0; C = 1;
        #10;
        $display("T = %b, C = %b, Q = %b, Qn = %b", T, C, Q, Qn);

        // Test case 3: T=1, C=1 (Toggle again)
        T = 1; C = 1;
        #10;
        $display("T = %b, C = %b, Q = %b, Qn = %b", T, C, Q, Qn);

        // Test case 4: T=0, C=0 (Hold state when clock is 0)
        T = 0; C = 0;
        #10;
        $display("T = %b, C = %b, Q = %b, Qn = %b", T, C, Q, Qn);

        // Test case 5: T=1, C=1 (Toggle again)
        T = 1; C = 1;
        #10;
        $display("T = %b, C = %b, Q = %b, Qn = %b", T, C, Q, Qn);

        // Finish simulation
        $finish;
    end

endmodule
