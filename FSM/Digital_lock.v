`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:35:09
// Design Name: 
// Module Name: Digital_lock
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

module digital_lock (
    input clk, reset,
    input [3:0] passcode_input,  // 4-bit passcode input
    input enter,                  // Trigger to check the passcode
    output reg lock_status       // Lock status (1 = Open, 0 = Closed)
);

    // Define the correct passcode (for example: 1010)
    localparam CORRECT_PASSCODE = 4'b1010;

    reg [3:0] entered_passcode;  // Register to store the entered passcode

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            entered_passcode <= 4'b0000; // Reset entered passcode
            lock_status <= 0;            // Lock closed initially
        end
        else if (enter) begin
            // When the enter signal is activated, compare entered passcode with the correct one
            if (entered_passcode == CORRECT_PASSCODE) 
                lock_status <= 1;  // Unlock the lock (Open)
            else
                lock_status <= 0;  // Keep the lock closed
        end
    end

    // Process the input passcode (store it each time it changes)
    always @(posedge clk) begin
        entered_passcode <= passcode_input; // Capture passcode input
    end

endmodule
