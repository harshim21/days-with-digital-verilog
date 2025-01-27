`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:57:34
// Design Name: 
// Module Name: decoder_tb
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


// Testbench for Decoder Counter
module decoder_counter_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg enable;
    wire [3:0] count;
    wire [15:0] decode;

    // Instantiate the Decoder Counter module
    decoder_counter uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .count(count),
        .decode(decode)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Testbench stimulus
    initial begin
        // Initialize inputs
        rst = 1;
        enable = 0;

        // Reset the system
        #10 rst = 0;

        // Enable the counter
        #10 enable = 1;

        // Run for a few clock cycles
        #200;

        // Disable the counter
        enable = 0;

        // End simulation
        #20 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | Count: %0b | Decode: %0b", $time, count, decode);
    end

endmodule
