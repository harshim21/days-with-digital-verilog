`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:35:53
// Design Name: 
// Module Name: DL_tb
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
module tb_digital_lock;

    // Declare inputs and outputs
    reg clk, reset;
    reg [3:0] passcode_input;
    reg enter;
    wire lock_status;

    // Instantiate the digital_lock module
    digital_lock uut (
        .clk(clk),
        .reset(reset),
        .passcode_input(passcode_input),
        .enter(enter),
        .lock_status(lock_status)
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
        passcode_input = 4'b0000;
        enter = 0;

        // Apply reset
        $display("Test 1: Applying reset");
        reset = 1; #10;
        reset = 0; #10;

        // Test with correct passcode (1010)
        $display("Test 2: Enter correct passcode (1010)");
        passcode_input = 4'b1010; // Correct passcode
        enter = 1; #10;
        enter = 0; #10; // Lock should open
        $display("Lock Status: %b", lock_status);

        // Test with incorrect passcode (1001)
        $display("Test 3: Enter incorrect passcode (1001)");
        passcode_input = 4'b1001; // Incorrect passcode
        enter = 1; #10;
        enter = 0; #10; // Lock should remain closed
        $display("Lock Status: %b", lock_status);

        // Test with another incorrect passcode (0000)
        $display("Test 4: Enter incorrect passcode (0000)");
        passcode_input = 4'b0000; // Incorrect passcode
        enter = 1; #10;
        enter = 0; #10; // Lock should remain closed
        $display("Lock Status: %b", lock_status);

        // Finish the simulation
        $finish;
    end

endmodule
