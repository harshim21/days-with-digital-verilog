`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.01.2025 10:57:50
// Design Name: 
// Module Name: SISO
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
module SISO #(parameter WIDTH = 4)(
    input wire clk,          // Clock signal
    input wire rst,          // Asynchronous reset 
    input wire serial_in,    // Serial data input
    output reg serial_out    // Serial data output
);
  // Internal register to hold the shift register values
    reg [WIDTH-1:0] shift_reg;

    always @(posedge clk or posedge rst)
 begin
        if (rst) begin
            shift_reg <= 0;        // Reset all bits to 0
           serial_out <= 0;       // Reset output to 0
        end else
            begin
            serial_out <= shift_reg[WIDTH-1]; 
                      // Output the MSB
           shift_reg <= {shift_reg[WIDTH-2:0], serial_in};
                  // Shift left and insert new input
     end
    end
endmodule
