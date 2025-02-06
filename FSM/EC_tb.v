`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:33:20
// Design Name: 
// Module Name: EC_tb
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

module tb_elevator_controller;

    // Declare inputs and outputs
    reg clk, reset;
    reg up_request, down_request;
    wire [1:0] floor;

    // Instantiate the elevator_controller module
    elevator_controller uut (
        .clk(clk),
        .reset(reset),
        .up_request(up_request),
        .down_request(down_request),
        .floor(floor)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Initial block to apply test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        up_request = 0;
        down_request = 0;

        // Apply reset
        $display("Test 1: Applying reset");
        reset = 1; #10;
        reset = 0; #10;
        
        // Test elevator movement (up request)
        $display("Test 2: Up request from Ground to First");
        up_request = 1; #10;
        up_request = 0; #10;
        
        // Test elevator movement (up request)
        $display("Test 3: Up request from First to Second");
        up_request = 1; #10;
        up_request = 0; #10;
        
        // Test elevator movement (down request)
        $display("Test 4: Down request from Second to First");
        down_request = 1; #10;
        down_request = 0; #10;
        
        // Test elevator movement (down request)
        $display("Test 5: Down request from First to Ground");
        down_request = 1; #10;
        down_request = 0; #10;

        // Test back and forth movement
        $display("Test 6: Up then Down requests");
        up_request = 1; #10;
        up_request = 0; #10;
        down_request = 1; #10;
        down_request = 0; #10;

        // Finish the simulation
        $finish;
    end

    // Monitor changes in the `floor` signal
    initial begin
        $monitor("Time: %0t | Floor: %b", $time, floor);
    end
endmodule
