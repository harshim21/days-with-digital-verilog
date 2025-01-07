`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.01.2025 16:47:43
// Design Name: 
// Module Name: tb_mux16_1
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
module tb_mux_16_1;

    // Inputs
    reg [15:0] d;
    reg [3:0] sel;

    // Output
    wire out;

    // Instantiate the Unit Under Test (UUT)
    mux_16_1 uut (
        .d(d), 
        .sel(sel), 
        .out(out)
    );

    initial begin
        // Initialize Inputs
        d = 16'b0000000000000000; sel = 4'b0000;
        #10;

        // Test all possible combinations of sel
        d = 16'b1010101010101010; sel = 4'b0000;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b0001;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b0010;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b0011;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b0100;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b0101;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b0110;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b0111;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1000;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1001;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1010;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1011;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1100;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1101;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1110;
        #10;
        
        d = 16'b1010101010101010; sel = 4'b1111;
        #10;

        // Add more test cases if needed
        $stop;
    end

    initial begin
        $monitor("At time %t, sel = %b, d = %b, out = %b", $time, sel, d, out);
    end

endmodule
