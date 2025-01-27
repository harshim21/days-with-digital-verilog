`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:52:10
// Design Name: 
// Module Name: BCD_counter
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

// BCD Counter in Verilog
module bcd_counter (
    input wire clk,          // Clock signal
    input wire rst,          // Reset signal (active high)
    input wire enable,       // Enable signal to increment the counter
    output reg [3:0] bcd_out // BCD counter output (4 bits)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to 0
            bcd_out <= 4'b0000;
        end else if (enable) begin
            if (bcd_out == 4'b1001) begin
                // Reset to 0 after reaching 9 (BCD limit)
                bcd_out <= 4'b0000;
            end else begin
                // Increment the counter
                bcd_out <= bcd_out + 1;
            end
        end
    end

endmodule
