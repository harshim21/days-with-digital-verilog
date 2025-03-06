`timescale 2ns / 1ps

module testbench;

	// Inputs
	reg [7:0] wdata;
	reg winc;
	reg wclk;
	reg wrst_n;
	reg rinc;
	reg rclk;
	reg rrst_n;

	// Outputs
	wire [7:0] rdata;
	wire wfull;
	wire rempty;

	// Instantiate the Unit Under Test (UUT)
	fifo1 uut (
		.rdata(rdata), 
		.wfull(wfull), 
		.rempty(rempty), 
		.wdata(wdata), 
		.winc(winc), 
		.wclk(wclk), 
		.wrst_n(wrst_n), 
		.rinc(rinc), 
		.rclk(rclk), 
		.rrst_n(rrst_n)
	);

	initial begin
		// Initialize Inputs
		wdata = 0;
		winc = 0;
		wclk = 0; //5ns
		wrst_n = 0; 
		rinc = 0;
		rclk = 0; //10ns
		rrst_n = 0;

		// Wait 10 ns for global reset to finish
		#10;
		wdata = 1;
		winc = 1;
		rinc = 1;
		wrst_n = 1;
		rrst_n = 1;
		
	end
	always begin 
		#5;
		wclk = ~wclk;
	end
	always begin 
		#10;
		rclk = ~rclk;
	end
      
endmodule

