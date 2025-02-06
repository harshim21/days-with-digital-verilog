`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:23:21
// Design Name: 
// Module Name: VM_tb
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

// Testbench for vending machine
module vending_machine_tb;
    reg clk, reset;
    reg [1:0] item_select;
    reg [3:0] money_inserted;
    wire dispense;
    wire [3:0] change;
    
    vending_machine uut (
        .clk(clk),
        .reset(reset),
        .item_select(item_select),
        .money_inserted(money_inserted),
        .dispense(dispense),
        .change(change)
    );
    
    always #5 clk = ~clk; // Clock toggle every 5 time units
    
    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        
        // Test Case 1: Insert exact money for item 1
        item_select = 2'b00;
        money_inserted = 4'd5;
        #10;
        
        // Test Case 2: Insert more money for item 2
        item_select = 2'b01;
        money_inserted = 4'd10;
        #10;
        
        // Test Case 3: Insert less money for item 3
        item_select = 2'b10;
        money_inserted = 4'd8;
        #10;
        
        // Test Case 4: Insert exact money for item 4
        item_select = 2'b11;
        money_inserted = 4'd12;
        #10;
        
        // Test Case 5: Reset the system
        reset = 1;
        #10 reset = 0;
        
        $stop;
    end
endmodule
