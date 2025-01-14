`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:53:25
// Design Name: 
// Module Name: D_FF_TB
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

module D_FlipFlop_tb;

    reg D, clk;
    wire Q, Qn;

    D_FlipFlop uut (
        .D(D),
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
        D = 0;
        #10;

        // Test cases
        D = 1; #10;
        D = 0; #10;
        D = 1; #10;

        $finish;
    end

endmodule
