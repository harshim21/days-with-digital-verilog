`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:29:57
// Design Name: 
// Module Name: tb_pg
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
module tb_parity_generator;

    // Testbench variables
    reg [3:0] data;     // 4 input data bits
    wire parity;        // Parity bit output

    // Instantiate the parity generator module
    parity_generator uut (
        .data(data),
        .parity(parity)
    );

    initial begin
        // Initialize inputs
        data = 4'b0000;
        
        // Apply test cases
        #10 data = 4'b0000;  // Expected parity: 0
        #10 data = 4'b0001;  // Expected parity: 1
        #10 data = 4'b0010;  // Expected parity: 1
        #10 data = 4'b0011;  // Expected parity: 0
        #10 data = 4'b0100;  // Expected parity: 1
        #10 data = 4'b0101;  // Expected parity: 0
        #10 data = 4'b0110;  // Expected parity: 0
        #10 data = 4'b0111;  // Expected parity: 1
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d data=%b parity=%b", $time, data, parity);
    end

endmodule

