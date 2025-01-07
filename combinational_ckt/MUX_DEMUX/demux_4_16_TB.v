`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 14:51:10
// Design Name: 
// Module Name: tb_demux_4_16
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
module tb_demux_4_to_16;

    // Testbench variables
    reg [3:0] sel;  // 4-bit select lines
    reg in;         // Input
    wire [15:0] y;  // 16 outputs

    // Instantiate the demux module
    demux_4_to_16 uut (
        .sel(sel),
        .in(in),
        .y(y)
    );

    initial begin
        // Initialize variables
        in = 1;
        sel = 4'b0000;
        
        // Test each select line
        #10 sel = 4'b0000;  // Select line 0
        #10 sel = 4'b0001;  // Select line 1
        #10 sel = 4'b0010;  // Select line 2
        #10 sel = 4'b0011;  // Select line 3
        #10 sel = 4'b0100;  // Select line 4
        #10 sel = 4'b0101;  // Select line 5
        #10 sel = 4'b0110;  // Select line 6
        #10 sel = 4'b0111;  // Select line 7
        #10 sel = 4'b1000;  // Select line 8
        #10 sel = 4'b1001;  // Select line 9
        #10 sel = 4'b1010;  // Select line 10
        #10 sel = 4'b1011;  // Select line 11
        #10 sel = 4'b1100;  // Select line 12
        #10 sel = 4'b1101;  // Select line 13
        #10 sel = 4'b1110;  // Select line 14
        #10 sel = 4'b1111;  // Select line 15

        // Finish simulation
        #10 $finish;
    end

endmodule
