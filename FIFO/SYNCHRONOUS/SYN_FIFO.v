`timescale 1ns/1ps
module sync_fifo #(parameter DEPTH=8, DWIDTH=16)
(
        input               	rstn,               // Active low reset
                            	clk,                // Clock
                            	wr_en, 				// Write enable
                            	rd_en, 				// Read enable
        input      [DWIDTH-1:0] din, 				// Data written into FIFO
        output reg [DWIDTH-1:0] dout, 				// Data read from FIFO
        output              	empty, 				// FIFO is empty when high
                            	full 				// FIFO is full when high
);


  reg [$clog2(DEPTH)-1:0]   wptr;
  reg [$clog2(DEPTH)-1:0]   rptr;

  reg [DWIDTH-1 : 0]fifo[DEPTH];

  always @ (posedge clk) begin
    if (!rstn) begin
      wptr <= 0;
    end else begin
      if (wr_en & !full) begin
        fifo[wptr] <= din;
        wptr <= wptr + 1;
      end
    end
  end

  initial begin
    $monitor("[%0t] [FIFO] wr_en=%0b din=0x%0h rd_en=%0b dout=0x%0h empty=%0b full=%0b",
             $time, wr_en, din, rd_en, dout, empty, full);
  end

  always @ (posedge clk) begin
    if (!rstn) begin
      rptr <= 0;
    end else begin
      if (rd_en & !empty) begin
        dout <= fifo[rptr];
        rptr <= rptr + 1;
      end
    end
  end

  assign full  = (wptr + 1) == rptr;
  assign empty = wptr == rptr;
endmodule



/////////////////////////////////////////////////////////////////////////////////////////////////////


module tb;

  reg 	 		clk;
  reg [15:0]    din;
  wire [15:0] 	dout;
  reg [15:0] 	rdata;
  reg 			empty;
  reg 			rd_en;
  reg 			wr_en;
  wire 			full;
  reg 			rstn;
  reg 			stop;

  sync_fifo u_sync_fifo ( .rstn(rstn),
                         .wr_en(wr_en),
                         .rd_en(rd_en),
                         .clk(clk),
                         .din(din),
                         .dout(dout),
                         .empty(empty),
                         .full(full)
                        );

  always #10 clk <= ~clk;

  initial begin
    clk 	<= 0;
    rstn 	<= 0;
    wr_en 	<= 0;
    rd_en 	<= 0;
    stop  	<= 0;

    #50 rstn <= 1;
  end

  initial begin
    @(posedge clk);

    for (int i = 0; i < 20; i = i+1) begin

      // Wait until there is space in fifo
      while (full) begin
      	@(posedge clk);
        $display("[%0t] FIFO is full, wait for reads to happen", $time);
      end;

      // Drive new values into FIFO
      wr_en <= $random;
      din 	<= $random;
      $display("[%0t] clk i=%0d wr_en=%0d din=0x%0h ", $time, i, wr_en, din);

      // Wait for next clock edge
      @(posedge clk);
    end

    stop = 1;
  end

  initial begin
    @(posedge clk);

    while (!stop) begin
      // Wait until there is data in fifo
      while (empty) begin
        rd_en <= 0;
        $display("[%0t] FIFO is empty, wait for writes to happen", $time);
        @(posedge clk);
      end;

      // Sample new values from FIFO at random pace
      rd_en <= $random;
      @(posedge clk);
      rdata <= dout;
      $display("[%0t] clk rd_en=%0d rdata=0x%0h ", $time, rd_en, rdata);
    end

    #500 $finish;
  end
endmodule
