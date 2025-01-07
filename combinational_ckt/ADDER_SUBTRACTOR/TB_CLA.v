`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:33:04
// Design Name: 
// Module Name: TB_CLA
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
module tb_cla_adder;

    // Testbench variables
    reg [3:0] a;       // First 4-bit input
    reg [3:0] b;       // Second 4-bit input
    reg cin;           // Carry input
    wire [3:0] sum;    // 4-bit sum output
    wire cout;         // Carry output

    // Instantiate the CLA adder module
    cla_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Initialize inputs
        a = 4'b0000; b = 4'b0000; cin = 0;
        
        // Apply test cases
        #10 a = 4'b0001; b = 4'b0001; cin = 0;  // Expected sum: 0002, Expected carry: 0
        #10 a = 4'b0010; b = 4'b0010; cin = 0;  // Expected sum: 0100, Expected carry: 0
        #10 a = 4'b0011; b = 4'b0011; cin = 0;  // Expected sum: 0110, Expected carry: 0
        #10 a = 4'b0100; b = 4'b0100; cin = 0;  // Expected sum: 1000, Expected carry: 0
        #10 a = 4'b1111; b = 4'b0001; cin = 1;  // Expected sum: 0001, Expected carry: 1
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d a=%b b=%b cin=%b sum=%b cout=%b", $time, a, b, cin, sum, cout);
    end

endmodule
