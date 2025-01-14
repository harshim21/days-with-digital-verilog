`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:52:05
// Design Name: 
// Module Name: SR_FF_TB
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
module SR_FlipFlop_tb;

    reg S, R, clk;
    wire Q, Qn;

    SR_FlipFlop uut (
        .S(S),
        .R(R),
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
        S = 0; R = 0;
        #10;

        // Test cases
        S = 1; R = 0; #10;  // Set
        S = 0; R = 1; #10;  // Reset
        S = 0; R = 0; #10;  // Hold
        S = 1; R = 1; #10;  // Invalid

        $finish;
    end

endmodule
