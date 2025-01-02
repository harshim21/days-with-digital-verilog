`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2025 14:35:12
// Design Name: 
// Module Name: testbench_mux
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


module testbench_mux();
reg [3:0]tdata;
reg [1:0]tsel;
reg tout;
MUX test_mux(
    tdata,
    tsel,
    tout
    );
  
  initial begin
   tdata<=4'b0000; tsel<= 2'b00;
   #10
   tdata<=4'b0010; tsel<= 2'b01;
    #10
   tdata<=4'b0100; tsel<= 2'b10;
    #10
   tdata<=4'b1000; tsel<= 2'b11;
    end
endmodule
