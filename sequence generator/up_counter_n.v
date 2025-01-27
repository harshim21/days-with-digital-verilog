`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:58:53
// Design Name: 
// Module Name: up_counter_n
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
// Up Counter for N Bits in Verilog
module up_counter #(parameter N = 4) (
    input wire clk,           // Clock signal
    input wire rst,           // Reset signal (active high)
    input wire enable,        // Enable signal to increment the counter
    output reg [N-1:0] count  // Counter output (N bits)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to 0
            count <= {N{1'b0}};
        end else if (enable) begin
            // Increment the counter
            count <= count + 1;
        end
    end

endmodule
