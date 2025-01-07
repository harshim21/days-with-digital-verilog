`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:20:23
// Design Name: 
// Module Name: TB_FS
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
module tb_full_subtractor;

    // Testbench variables
    reg a;        // Minuend
    reg b;        // Subtrahend
    reg bin;      // Borrow in
    wire diff;    // Difference output
    wire bout;    // Borrow out

    // Instantiate the full subtractor module
    full_subtractor uut (
        .a(a),
        .b(b),
        .bin(bin),
        .diff(diff),
        .bout(bout)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0; bin = 0;
        
        // Apply test cases
        #10 a = 0; b = 0; bin = 0;  // Expected diff: 0, Expected borrow: 0
        #10 a = 0; b = 0; bin = 1;  // Expected diff: 1, Expected borrow: 1
        #10 a = 0; b = 1; bin = 0;  // Expected diff: 1, Expected borrow: 1
        #10 a = 0; b = 1; bin = 1;  // Expected diff: 0, Expected borrow: 1
        #10 a = 1; b = 0; bin = 0;  // Expected diff: 1, Expected borrow: 0
        #10 a = 1; b = 0; bin = 1;  // Expected diff: 0, Expected borrow: 1
        #10 a = 1; b = 1; bin = 0;  // Expected diff: 0, Expected borrow: 0
        #10 a = 1; b = 1; bin = 1;  // Expected diff: 1, Expected borrow: 1
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d a=%b b=%b bin=%b diff=%b bout=%b", $time, a, b, bin, diff, bout);
    end

endmodule

