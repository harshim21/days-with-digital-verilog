`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:42:51
// Design Name: 
// Module Name: gray_code
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
// Gray Code Sequence Generator in Verilog
module gray_code_generator (
    input wire clk,            // Clock signal
    input wire rst,            // Reset signal (active high)
    input wire enable,         // Enable signal to start generating Gray code
    input wire [3:0] num_bits, // Number of bits for the Gray code
    output reg [15:0] gray_out // Current Gray code output (maximum 16 bits)
);

    reg [15:0] binary; // Register to store the binary counter

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the binary counter and Gray code output
            binary <= 0;
            gray_out <= 0;
        end else if (enable) begin
            // Increment the binary counter
            binary <= binary + 1;

            // Convert binary to Gray code
            gray_out <= binary ^ (binary >> 1);
        end
    end

endmodule
