`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 15:39:57
// Design Name: 
// Module Name: test
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
module data_generator (
    input wire clk1,           // Clock for source domain
    input wire rst,            // Reset signal
    output reg [7:0] data_out // Data output to transfer
);

    // Simple 8-bit LFSR (Linear Feedback Shift Register) for pseudo-random data
    reg [7:0] lfsr;

    always @(posedge clk1 or posedge rst) begin
        if (rst) begin
            lfsr <= 8'b10101010; // Seed value for LFSR
            data_out <= 8'b0;
        end else begin
            lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5]}; // Shift left with feedback
            data_out <= lfsr;
        end
    end
endmodule
