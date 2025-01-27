`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:47:23
// Design Name: 
// Module Name: psedo-rand
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

// Pseudo-Random Sequence Generator in Verilog
module pseudo_random_generator (
    input wire clk,            // Clock signal
    input wire rst,            // Reset signal (active high)
    input wire enable,         // Enable signal to start generating sequence
    input wire [3:0] seed,     // Seed value for the LFSR
    output reg [3:0] prbs_out  // Current pseudo-random sequence output (4 bits)
);

    reg [3:0] lfsr; // Linear Feedback Shift Register

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Initialize the LFSR with the seed value on reset
            lfsr <= seed;
            prbs_out <= seed;
        end else if (enable) begin
            // Generate the next state of the LFSR
            lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[2]};

            // Update the pseudo-random sequence output
            prbs_out <= lfsr;
        end
    end

endmodule
