`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2025 15:43:28
// Design Name: 
// Module Name: fifo
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

module fifo #(
    parameter WIDTH = 8,          // Data width
    parameter DEPTH = 16          // FIFO depth
)(
    input wire clk_write,         // Write clock (clk1)
    input wire clk_read,          // Read clock (clk2)
    input wire rst,               // Reset signal
    input wire [WIDTH-1:0] data_in, // Data input (from clk1)
    output reg [WIDTH-1:0] data_out, // Data output (to clk2)
    output reg fifo_empty,         // FIFO empty flag
    output reg fifo_full           // FIFO full flag
);

    reg [WIDTH-1:0] fifo_mem [0:DEPTH-1];  // FIFO memory array
    reg [4:0] write_ptr, read_ptr;          // Pointers for write and read operations
    reg [4:0] fifo_count;                   // FIFO element count

    always @(posedge clk_write or posedge rst) begin
        if (rst) begin
            write_ptr <= 0;
            fifo_count <= 0;
            fifo_full <= 0;
        end else if (fifo_count < DEPTH) begin
            fifo_mem[write_ptr] <= data_in;    // Write data to FIFO
            write_ptr <= write_ptr + 1;
            fifo_count <= fifo_count + 1;
            fifo_full <= (fifo_count == DEPTH);
        end
    end

    always @(posedge clk_read or posedge rst) begin
        if (rst) begin
            read_ptr <= 0;
            fifo_empty <= 1;
        end else if (fifo_count > 0) begin
            data_out <= fifo_mem[read_ptr];    // Read data from FIFO
            read_ptr <= read_ptr + 1;
            fifo_count <= fifo_count - 1;
            fifo_empty <= (fifo_count == 0);
        end
    end
endmodule
