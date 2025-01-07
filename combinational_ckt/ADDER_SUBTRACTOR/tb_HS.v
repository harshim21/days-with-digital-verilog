`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:18:42
// Design Name: 
// Module Name: tb_HS
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

module tb_half_subtractor;

    // Testbench variables
    reg a;       // Minuend
    reg b;       // Subtrahend
    wire diff;   // Difference output
    wire borrow; // Borrow output

    // Instantiate the half subtractor module
    half_subtractor uut (
        .a(a),
        .b(b),
        .diff(diff),
        .borrow(borrow)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        
        // Apply test cases
        #10 a = 0; b = 0;  // Expected diff: 0, Expected borrow: 0
        #10 a = 0; b = 1;  // Expected diff: 1, Expected borrow: 1
        #10 a = 1; b = 0;  // Expected diff: 1, Expected borrow: 0
        #10 a = 1; b = 1;  // Expected diff: 0, Expected borrow: 0
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d a=%b b=%b diff=%b borrow=%b", $time, a, b, diff, borrow);
    end

endmodule
