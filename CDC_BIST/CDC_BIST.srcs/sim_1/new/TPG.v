`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 12:40:20
// Design Name: 
// Module Name: TPG
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
module lfsr_pattern_generator (
    input wire clk,       // Clock for generating the pattern
    input wire rst,       // Reset signal
    output reg [3:0] lfsr_out // 4-bit pseudo-random output pattern
);

    // Feedback taps for a 4-bit LFSR (this example uses taps at bit positions 4 and 3)
    wire feedback;

    // Calculate feedback using XOR on specific bits
    assign feedback = lfsr_out[3] ^ lfsr_out[2];

    // Shift register logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr_out <= 4'b1111; // Initialize the LFSR to a non-zero value (avoid all zeros)
        end else begin
            lfsr_out <= {lfsr_out[2:0], feedback}; // Shift and insert the feedback
        end
    end

endmodule


