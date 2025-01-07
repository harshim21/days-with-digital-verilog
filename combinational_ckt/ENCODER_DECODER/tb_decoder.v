`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:12:10
// Design Name: 
// Module Name: tb_decoder
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
module tb_decoder_2_to_4;

    // Testbench variables
    reg [1:0] in;       // 2 input lines
    wire [3:0] out;     // 4 output lines

    // Instantiate the decoder module
    decoder_2_to_4 uut (
        .in(in),
        .out(out)
    );

    initial begin
        // Initialize inputs
        in = 2'b00;
        
        // Apply test cases
        #10 in = 2'b00;  // Expected output: 4'b0001
        #10 in = 2'b01;  // Expected output: 4'b0010
        #10 in = 2'b10;  // Expected output: 4'b0100
        #10 in = 2'b11;  // Expected output: 4'b1000
        
        // Finish simulation
        #10 $finish;
    end

    initial begin
        // Monitor changes
        $monitor("Time=%0d in=%b out=%b", $time, in, out);
    end

endmodule
