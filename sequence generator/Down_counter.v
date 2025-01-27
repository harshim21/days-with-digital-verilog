`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 16:00:30
// Design Name: 
// Module Name: Down_counter
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
// Down Counter for N Bits in Verilog
module down_counter #(parameter N = 4) (
    input wire clk,           // Clock signal
    input wire rst,           // Reset signal (active high)
    input wire enable,        // Enable signal to decrement the counter
    output reg [N-1:0] count  // Counter output (N bits)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to its maximum value
            count <= {N{1'b1}};
        end else if (enable) begin
            // Decrement the counter
            count <= count - 1;
        end
    end

endmodule