`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 14:58:28
// Design Name: 
// Module Name: tb_encoder
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

module tb_encoder_4_to_2;

    // Testbench variables
    reg [3:0] in;       // 4 input lines
    wire [1:0] out;     // 2 output lines

    // Instantiate the encoder module
    encoder_4_to_2 uut (
        .in(in),
        .out(out)
    );

    initial begin
        // Initialize inputs
        in = 4'b0000;
        
        // Apply test cases
        #10 in = 4'b0001;  // Expected output: 2'b00
        #10 in = 4'b0010;  // Expected output: 2'b01
        #10 in = 4'b0100;  // Expected output: 2'b10
        #10 in = 4'b1000;  // Expected output: 2'b11
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d in=%b out=%b", $time, in, out);
    end

endmodule
