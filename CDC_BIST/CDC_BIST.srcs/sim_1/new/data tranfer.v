`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 15:41:14
// Design Name: 
// Module Name: data tranfer
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

module data_transfer (
    input wire clk1,           // Clock for source domain
    input wire clk2,           // Clock for destination domain
    input wire rst,            // Reset signal
    input wire [7:0] data_in,  // Input data from clk1
    output reg [7:0] data_out  // Output data to clk2
);

    always @(posedge clk2 or posedge rst) begin
        if (rst) begin
            data_out <= 8'b0;
        end else begin
            data_out <= data_in; // Direct transfer without synchronization
        end
    end
endmodule
