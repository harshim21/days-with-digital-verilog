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

`timescale 1ns / 1ps

module tb_MUX_21;

    // Inputs
    reg [1:0] data;
    reg sel;

    // Outputs
    wire out;

    // Instantiate the Unit Under Test (UUT)
    MUX_21 uut (
        .data(data),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Initialize Inputs
        data = 2'b00;
        sel = 0;
        #10;
        
        data = 2'b01;
        sel = 0;
        #10;
        
        data = 2'b10;
        sel = 1;
        #10;
        
        data = 2'b11;
        sel = 1;
        #10;

        // Additional test cases
        data = 2'b10;
        sel = 0;
        #10;
        
        data = 2'b01;
        sel = 1;
        #10;

        $stop;  // Stop simulation
    end

endmodule
