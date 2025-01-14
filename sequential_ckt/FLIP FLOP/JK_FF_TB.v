`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:55:26
// Design Name: 
// Module Name: JK_FF_TB
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
module JK_FlipFlop_tb;

    reg J, K, clk;
    wire Q, Qn;

    JK_FlipFlop uut (
        .J(J),
        .K(K),
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
        J = 0; K = 0; #10; // Hold
        J = 1; K = 0; #10; // Set
        J = 0; K = 1; #10; // Reset
        J = 1; K = 1; #10; // Toggle

        $finish;
    end

endmodule
