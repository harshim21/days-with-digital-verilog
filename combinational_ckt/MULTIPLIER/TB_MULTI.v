`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:24:15
// Design Name: 
// Module Name: TB_MULTI
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
module tb_multiplier;

    // Testbench variables
    reg [3:0] a;       // First 4-bit input
    reg [3:0] b;       // Second 4-bit input
    wire [7:0] product; // 8-bit product output

    // Instantiate the multiplier module
    multiplier uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        // Initialize inputs
        a = 4'b0000; b = 4'b0000;
        
        // Apply test cases
        #10 a = 4'b0001; b = 4'b0001;  // Expected product: 00000001
        #10 a = 4'b0010; b = 4'b0010;  // Expected product: 00000100
        #10 a = 4'b0011; b = 4'b0011;  // Expected product: 00001001
        #10 a = 4'b0100; b = 4'b0100;  // Expected product: 00010000
        #10 a = 4'b0101; b = 4'b0101;  // Expected product: 00100001
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d a=%b b=%b product=%b", $time, a, b, product);
    end

endmodule

