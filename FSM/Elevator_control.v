`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:29:51
// Design Name: 
// Module Name: Elevator_control
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
module elevator_controller (
    input clk, reset,
    input up_request, down_request,
    output reg [1:0] floor // 2-bit floor indicator (00 = Ground, 01 = First, 10 = Second, etc.)
);

    // State encoding using localparam
    localparam GROUND = 2'b00, FIRST = 2'b01, SECOND = 2'b10;
    
    reg [1:0] current_state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= GROUND;
        else
            current_state <= next_state;
    end
    
    always @(*) begin
        case (current_state)
            GROUND: if (up_request) next_state = FIRST; else next_state = GROUND;
            FIRST: if (up_request) next_state = SECOND;
                   else if (down_request) next_state = GROUND;
                   else next_state = FIRST;
            SECOND: if (down_request) next_state = FIRST; else next_state = SECOND;
            default: next_state = GROUND;
        endcase
    end
    
    always @(*) begin
        floor = current_state;
    end
endmodule

