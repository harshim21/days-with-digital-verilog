`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:55:29
// Design Name: 
// Module Name: DECODER
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
// Decoder Counter in Verilog
module decoder_counter (
    input wire clk,          // Clock signal
    input wire rst,          // Reset signal (active high)
    input wire enable,       // Enable signal to increment the counter
    output reg [3:0] count,  // Binary count output
    output reg [15:0] decode // Decoded output (1-hot representation)
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the counter to 0 and decoded output to all zeros
            count <= 4'b0000;
            decode <= 16'b0000_0000_0000_0001;
        end else if (enable) begin
            if (count == 4'b1111) begin
                // Wrap around after reaching 15
                count <= 4'b0000;
            end else begin
                // Increment the counter
                count <= count + 1;
            end
            // Update the decoded output based on the counter value
            decode <= 16'b0000_0000_0000_0001 << count;
        end
    end

endmodule
