`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:21:54
// Design Name: 
// Module Name: TB_MV
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
module tb_majority_voter;

    // Testbench variables
    reg a;       // First input
    reg b;       // Second input
    reg c;       // Third input
    wire out;    // Output

    // Instantiate the majority voter module
    majority_voter uut (
        .a(a),
        .b(b),
        .c(c),
        .out(out)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0; c = 0;
        
        // Apply test cases
        #10 a = 0; b = 0; c = 0;  // Expected output: 0
        #10 a = 0; b = 0; c = 1;  // Expected output: 0
        #10 a = 0; b = 1; c = 0;  // Expected output: 0
        #10 a = 0; b = 1; c = 1;  // Expected output: 1
        #10 a = 1; b = 0; c = 0;  // Expected output: 0
        #10 a = 1; b = 0; c = 1;  // Expected output: 1
        #10 a = 1; b = 1; c = 0;  // Expected output: 1
        #10 a = 1; b = 1; c = 1;  // Expected output: 1
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d a=%b b=%b c=%b out=%b", $time, a, b, c, out);
    end

endmodule
