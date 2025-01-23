`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 10:58:56
// Design Name: 
// Module Name: SIPO
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

module SIPO #(parameter WIDTH = 4)(
    input wire clk,          // Clock signal
    input wire rst,          // Asynchronous reset (active high)
    input wire serial_in,    // Serial data input
    output reg [WIDTH-1:0] parallel_out // Parallel data output
);
 // Internal register to hold the shift register values
    reg [WIDTH-1:0] shift_reg;
always @(posedge clk or posedge rst) 
    begin
        if (rst) begin
            shift_reg <= 0;          // Reset all bits to 0         
        parallel_out <= 0;       // Reset parallel output to 0
       end
 else begin
 shift_reg <= {shift_reg[WIDTH-2:0], serial_in};
      // Shift left 
  parallel_out <= shift_reg;   // Update parallel output
        end
    end
endmodule
