`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 10:59:53
// Design Name: 
// Module Name: PISO
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
module PISO (
    input clk,              // Clock signal
    input rst_n,            // Active-low reset
    input load,             // Load signal (to load parallel data)
    input [7:0] parallel_in,// 8-bit parallel input
    output reg serial_out   // Serial output               
     );  
    reg [7:0] shift_reg;       // 8-bit shift register
always @(posedge clk or negedge rst_n)
 begin
    if (~rst_n) begin
        shift_reg <= 8'b0;  // Reset the shift register
        serial_out <= 0;     // Reset serial output
    end else if (load) begin
        shift_reg <= parallel_in; // Load parallel data
        serial_out <= shift_reg[7]; // Output MSB initially
    end 
else begin
        serial_out <= shift_reg[7]; // Output MSB of the register
        shift_reg <= shift_reg << 1; // Shift left
    end
end
endmodule
