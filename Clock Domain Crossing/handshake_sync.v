`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2025 14:36:22
// Design Name: 
// Module Name: handshake_sync
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

// 2-Stage Handshake Synchronizer
module handshake_synchronizer_2stage (
    input wire clk_src,          // Source clock
    input wire clk_dest,         // Destination clock
    input wire req_src,    // Request signal from source 
    input wire [7:0] data_in,    // Data from source 
    output reg ack_dest,    // Acknowledge signal in destination
    output reg [7:0] data_out    // Data in destination domain
);
    reg req_sync1, req_sync2;    // Synchronization of req_src
    reg ack_sync1, ack_src;      // Synchronization of ack_dest
   
    always @(posedge clk_dest) begin
        req_sync1 <= req_src;
        req_sync2 <= req_sync1;
    end
   
    always @(posedge clk_dest) begin
       if (req_sync2 && !ack_dest) begin
            data_out <= data_in;  // Capture data from source
            ack_dest <= 1'b1;     // Assert acknowledge signal
        end else if (!req_sync2) begin
            ack_dest <= 1'b0;     
        end
    end

    always @(posedge clk_src) begin
        ack_sync1 <= ack_dest;
        ack_src <= ack_sync1;
    end 
endmodule 

// Testbench for Handshake Synchronizer
module tb_handshake_synchronizer_2stage;
    reg clk_src, clk_dest;
    reg req_src;
    reg [7:0] data_in;
    wire ack_dest;
    wire [7:0] data_out;
    
    // Instantiate the module
    handshake_synchronizer_2stage uut (
        .clk_src(clk_src),
        .clk_dest(clk_dest),
        .req_src(req_src),
        .data_in(data_in),
        .ack_dest(ack_dest),
        .data_out(data_out)
    );
    
    // Clock generation
    always #5 clk_src = ~clk_src;
    always #7 clk_dest = ~clk_dest;
    
    initial begin
        // Initialize signals
        clk_src = 0;
        clk_dest = 0;
        req_src = 0;
        data_in = 8'h00;
        
        // Test sequence
        #10 req_src = 1; data_in = 8'hA5;
        #20 req_src = 0;
        #30 req_src = 1; data_in = 8'h3C;
        #40 req_src = 0;
        #50 req_src = 1; data_in = 8'h7F;
        #60 req_src = 0;
        #70 $stop;
    end
endmodule
