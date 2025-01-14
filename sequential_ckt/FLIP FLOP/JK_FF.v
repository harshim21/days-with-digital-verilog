`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2025 19:54:53
// Design Name: 
// Module Name: JK_FF
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

module JK_FlipFlop (
    input J,    // J input
    input K,    // K input
    input clk,  // Clock input
    output reg Q, // Output
    output Qn   // Complement of output
);

    assign Qn = ~Q;

    always @(posedge clk) begin
        case ({J, K})
            2'b00: Q <= Q;      // Hold
            2'b01: Q <= 0;      // Reset
            2'b10: Q <= 1;      // Set
            2'b11: Q <= ~Q;     // Toggle
        endcase
    end

endmodule
