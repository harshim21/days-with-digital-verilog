`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 15:42:49
// Design Name: 
// Module Name: sync3
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
module sync2 (
    input wire clk,           // Clock for destination domain (clk2)
    input wire rst,           // Reset signal
    input wire src,           // Input signal from source domain (clk1)
    output reg synced         // Synchronized signal for destination domain
);

    reg sync1, sync2;         // Two-stage synchronizer registers

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sync1 <= 0;
            sync2 <= 0;
            synced <= 0;
        end else begin
            sync1 <= src;     // First stage of synchronization
            sync2 <= sync1;   // Second stage of synchronization
            synced <= sync2;  // Output synchronized signal
        end
    end
endmodule
