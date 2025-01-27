`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 12:38:00
// Design Name: 
// Module Name: fb_series
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
// Fibonacci Sequence Generator in Verilog
module fibonacci_generator(
    input wire clk,                // Clock signal
    input wire rst,                // Reset signal (active high)
    input wire enable,             // Enable signal to start generating the sequence
    input wire [31:0] max_value,   // Maximum value for the Fibonacci sequence
    output reg [31:0] fib_out,     // Current Fibonacci number
    output reg done                // Signal to indicate completion
);

    // Internal registers to hold the previous two Fibonacci numbers
    reg [31:0] fib1;
    reg [31:0] fib2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all outputs and internal registers
            fib1 <= 0;
            fib2 <= 1;
            fib_out <= 0;
            done <= 0;
        end else if (enable && !done) begin
            // Generate the next Fibonacci number
            fib_out <= fib1;
            fib1 <= fib2;
            fib2 <= fib1 + fib2;

            // Check if the next Fibonacci number exceeds max_value
            if (fib1 + fib2 > max_value) begin
                done <= 1; // Indicate completion
            end
        end
    end

endmodule

