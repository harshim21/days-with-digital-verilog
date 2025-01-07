`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 15:27:10
// Design Name: 
// Module Name: multi
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

module multiplier (
    input wire [3:0] a,    // First 4-bit input
    input wire [3:0] b,    // Second 4-bit input
    output reg [7:0] product // 8-bit product output
);

    reg [7:0] partial_sum;
    integer i;

    always @(*) begin
        partial_sum = 8'b0;
        for (i = 0; i < 4; i = i + 1) begin
            if (b[i])
                partial_sum = partial_sum + (a << i);
        end
        product = partial_sum;
    end

endmodule
