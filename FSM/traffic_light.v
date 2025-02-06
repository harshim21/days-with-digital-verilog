`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:24:40
// Design Name: 
// Module Name: traffic_light
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
module traffic_light(
    input clk, reset,
    output reg [2:0] light // 3-bit output for Red, Yellow, Green
);
    
    // Define state encoding
    localparam RED = 2'b00, GREEN = 2'b01, YELLOW = 2'b10;
    reg [1:0] current_state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= RED;
        else
            current_state <= next_state;
    end
    
    always @(*) begin
        case (current_state)
            RED: next_state = GREEN;
            GREEN: next_state = YELLOW;
            YELLOW: next_state = RED;
            default: next_state = RED;
        endcase
    end
    
    always @(*) begin
        case (current_state)
            RED: light = 3'b100;
            GREEN: light = 3'b001;
            YELLOW: light = 3'b010;
            default: light = 3'b100;
        endcase
    end
endmodule
