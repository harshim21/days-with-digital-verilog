`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:56:45
// Design Name: 
// Module Name: T_FF_TB
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
module T_FlipFlop_tb;

    reg T, clk;
    wire Q, Qn;

    T_FlipFlop uut (
        .T(T),
        .clk(clk),
        .Q(Q),
        .Qn(Qn)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate clock
    end

    initial begin
        // Initialize inputs
        T = 0; #10; // Hold
        T = 1; #10; // Toggle
        T = 1; #10; // Toggle again
        T = 0; #10; // Hold

        $finish;
    end

endmodule
