`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2025 15:32:45
// Design Name: 
// Module Name: fab_tb
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

// Testbench for Fibonacci Sequence Generator
module fibonacci_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg enable;
    reg [31:0] max_value;
    wire [31:0] fib_out;
    wire done;

    // Instantiate the Fibonacci generator module
    fibonacci_generator uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .max_value(max_value),
        .fib_out(fib_out),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Stimulus generation
    initial begin
        // Initialize inputs
        rst = 1;
        enable = 0;
        max_value = 50; // Generate Fibonacci numbers up to 50

        // Reset the system
        #10 rst = 0;

        // Enable the Fibonacci generator
        #10 enable = 1;

        // Wait for the generation to complete
        wait(done);

        // Disable the enable signal
        #10 enable = 0;

        // End simulation
        #20 $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | Fibonacci Output: %0d | Done: %b", $time, fib_out, done);
    end

endmodule

