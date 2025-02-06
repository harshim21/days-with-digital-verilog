`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.02.2025 11:25:51
// Design Name: 
// Module Name: TF_tb
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

// Testbench for traffic light
module traffic_light_tb;
    reg clk, reset;
    wire [2:0] light;
    
    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .light(light)
    );
    
    always #5 clk = ~clk; // Clock toggle every 5 time units
    
    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        
        #50; // Let the traffic light cycle through states
        
        reset = 1;
        #10 reset = 0;
        
        $stop;
    end
endmodule
