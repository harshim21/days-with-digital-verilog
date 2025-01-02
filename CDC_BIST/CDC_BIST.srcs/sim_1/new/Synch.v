`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 12:51:18
// Design Name: 
// Module Name: Synch
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

module sync2_m (
    input wire clk,       // Clock for destination domain (clk2)
    input wire rst,       // Reset signal
    input wire src,       // Signal from source domain (clk1)
    output reg synced     // Synchronized signal to destination domain
);

    reg sync1; // Intermediate signal after first flip-flop

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sync1 <= 0;    // Reset first flip-flop
            synced <= 0;   // Reset second flip-flop
        end else begin
            sync1 <= src;  // Capture source signal in first FF
            synced <= sync1; // Stabilize signal in second FF
        end
    end
endmodule

