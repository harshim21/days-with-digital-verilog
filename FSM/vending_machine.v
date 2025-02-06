`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:09:56
// Design Name: 
// Module Name: vending_machine
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

module vending_machine(
    input clk, reset,
    input [1:0] item_select, // 2-bit selection for item (00, 01, 10, 11)
    input [3:0] money_inserted, // 4-bit money input
    output reg dispense,
    output reg [3:0] change
);

    // Define item costs
    parameter ITEM1_COST = 4'd5;
    parameter ITEM2_COST = 4'd7;
    parameter ITEM3_COST = 4'd10;
    parameter ITEM4_COST = 4'd12;
    
    reg [3:0] cost;
    
    always @(*) begin
        case(item_select)
            2'b00: cost = ITEM1_COST;
            2'b01: cost = ITEM2_COST;
            2'b10: cost = ITEM3_COST;
            2'b11: cost = ITEM4_COST;
            default: cost = 4'd0;
        endcase
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dispense <= 0;
            change <= 4'd0;
        end else begin
            if (money_inserted >= cost) begin
                dispense <= 1;
                change <= money_inserted - cost;
            end else begin
                dispense <= 0;
                change <= money_inserted; // Refund if not enough money
            end
        end
    end
endmodule
