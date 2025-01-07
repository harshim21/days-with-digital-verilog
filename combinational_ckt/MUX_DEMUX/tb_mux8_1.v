`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.01.2025 16:37:44
// Design Name: 
// Module Name: tb_mux8_1
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
module tb_mux8_1;

    // Inputs
    reg [7:0] d;
    reg [2:0] sel;

    // Output
    wire out;

    // Instantiate the Unit Under Test (UUT)
    mux8_1 uut (
        .d(d), 
        .sel(sel), 
        .out(out)
    );

    initial begin
        // Initialize Inputs
        d = 8'b00000000; sel = 3'b000;
        #10;

        // Test all possible combinations of sel
        d = 8'b10101010; sel = 3'b000;
        #10;
        
        d = 8'b10101010; sel = 3'b001;
        #10;
        
        d = 8'b10101010; sel = 3'b010;
        #10;
        
        d = 8'b10101010; sel = 3'b011;
        #10;
        
        d = 8'b10101010; sel = 3'b100;
        #10;
        
        d = 8'b10101010; sel = 3'b101;
        #10;
        
        d = 8'b10101010; sel = 3'b110;
        #10;
        
        d = 8'b10101010; sel = 3'b111;
        #10;

        // Add more test cases if needed
        $stop;
    end

    initial begin
        $monitor("At time %t, sel = %b, d = %b, out = %b", $time, sel, d, out);
    end

endmodule
