`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2025 15:09:00
// Design Name: 
// Module Name: D_LATCH_TB
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
module D_Latch_tb;

    // Declare testbench signals
    reg D, C;   // Inputs to D latch
    wire Q, Qn; // Outputs from D latch

    // Instantiate the D_Latch module
    D_Latch uut (
        .D(D),
        .C(C),
        .Q(Q),
        .Qn(Qn)
    );

    // Test sequence
    initial begin
        // Initialize inputs
        D = 0; C = 0;
        #10; // Wait for 10 time units

        // Test case 1: Set data when clock is high (D=1, C=1)
        D = 1; C = 1;
        #10;
        $display("D = %b, C = %b, Q = %b, Qn = %b", D, C, Q, Qn);

        // Test case 2: Keep data when clock is low (D=1, C=0)
        D = 1; C = 0;
        #10;
        $display("D = %b, C = %b, Q = %b, Qn = %b", D, C, Q, Qn);

        // Test case 3: Reset data when clock is high (D=0, C=1)
        D = 0; C = 1;
        #10;
        $display("D = %b, C = %b, Q = %b, Qn = %b", D, C, Q, Qn);

        // Test case 4: Keep data when clock is low (D=0, C=0)
        D = 0; C = 0;
        #10;
        $display("D = %b, C = %b, Q = %b, Qn = %b", D, C, Q, Qn);

        // Finish simulation
        $finish;
    end

endmodule
