`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:11:52
// Design Name: 
// Module Name: JK_LATCH_TB
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

module JK_Latch_tb;

    // Declare testbench signals
    reg J, K, C;  // Inputs to JK latch
    wire Q, Qn;   // Outputs from JK latch

    // Instantiate the JK_Latch module
    JK_Latch uut (
        .J(J),
        .K(K),
        .C(C),
        .Q(Q),
        .Qn(Qn)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        J = 0; K = 0; C = 0;
        #10; // Wait for 10 time units

        // Test case 1: J=1, K=0 (Set operation)
        J = 1; K = 0; C = 1;
        #10;
        $display("J = %b, K = %b, C = %b, Q = %b, Qn = %b", J, K, C, Q, Qn);

        // Test case 2: J=0, K=1 (Reset operation)
        J = 0; K = 1; C = 1;
        #10;
        $display("J = %b, K = %b, C = %b, Q = %b, Qn = %b", J, K, C, Q, Qn);

        // Test case 3: J=0, K=0 (Hold previous state)
        J = 0; K = 0; C = 1;
        #10;
        $display("J = %b, K = %b, C = %b, Q = %b, Qn = %b", J, K, C, Q, Qn);

        // Test case 4: J=1, K=1 (Toggle operation)
        J = 1; K = 1; C = 1;
        #10;
        $display("J = %b, K = %b, C = %b, Q = %b, Qn = %b", J, K, C, Q, Qn);

        // Test case 5: J=1, K=1 (Toggle again)
        J = 1; K = 1; C = 1;
        #10;
        $display("J = %b, K = %b, C = %b, Q = %b, Qn = %b", J, K, C, Q, Qn);

        // Test case 6: J=0, K=0 (Hold state again)
        J = 0; K = 0; C = 0;
        #10;
        $display("J = %b, K = %b, C = %b, Q = %b, Qn = %b", J, K, C, Q, Qn);

        // Finish simulation
        $finish;
    end

endmodule
