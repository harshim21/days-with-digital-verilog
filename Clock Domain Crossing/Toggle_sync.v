`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2025 14:45:01
// Design Name: 
// Module Name: Toggle_sync
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

// Toggle Synchronizer
module toggle_synchronizer (
    input wire clk_src,         // Source clock
    input wire clk_dest,        // Destination clock
    input wire event_src,       // Event signal in source domain
    output wire event_dest      // Synchronized event in destination domain
);
    reg toggle_src;             // Toggle bit in source domain
    reg sync1, sync2;           // Synchronizer flip-flops in destination domain
    reg toggle_dest;            // Toggle bit in destination domain

    // Step 1: Generate the toggle signal in the source domain
    always @(posedge clk_src) begin
        if (event_src)
            toggle_src <= ~toggle_src;  // Flip the toggle bit on event
    end

    // Step 2: Synchronize the toggle bit into the destination clock domain
    always @(posedge clk_dest) begin
        sync1 <= toggle_src;            // First stage of synchronization
        sync2 <= sync1;                 // Second stage of synchronization
    end

    // Step 3: Detect the toggle change in the destination domain
    always @(posedge clk_dest) begin
        toggle_dest <= sync2;           // Capture the synchronized toggle bit
    end

    // Generate the event in the destination domain when toggle changes
    assign event_dest = toggle_dest ^ sync2; // XOR to detect edge
endmodule


// Testbench for Toggle Synchronizer
module tb_toggle_synchronizer;
    reg clk_src, clk_dest;
    reg event_src;
    wire event_dest;
    
    // Instantiate the DUT (Device Under Test)
    toggle_synchronizer uut (
        .clk_src(clk_src),
        .clk_dest(clk_dest),
        .event_src(event_src),
        .event_dest(event_dest)
    );
    
    // Generate source clock
    always #5 clk_src = ~clk_src;
    
    // Generate destination clock
    always #7 clk_dest = ~clk_dest;
    
    initial begin
        // Initialize signals
        clk_src = 0;
        clk_dest = 0;
        event_src = 0;
        
        // Apply test stimulus
        #10 event_src = 1;
        #10 event_src = 0;
        #20 event_src = 1;
        #10 event_src = 0;
        #30 event_src = 1;
        #10 event_src = 0;
        
        // End simulation
        #100 $finish;
    end
    
    // Monitor the signals
    initial begin
        $monitor("Time: %0t | event_src: %b | event_dest: %b", $time, event_src, event_dest);
    end
endmodule

