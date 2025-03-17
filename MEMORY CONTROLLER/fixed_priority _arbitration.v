module fixed_priority_arbiter (
    input wire clk, reset,
    input wire req1, req2, req3,  
// Memory access requests
    output reg grant1, grant2, grant3
 // Granted access
);
 always @(posedge clk or posedge reset) begin
     if (reset) begin
       grant1 <= 0;
       grant2 <= 0;
       grant3 <= 0;
     end else begin
  // Fixed priority: req1 > req2 > req3
      if (req1) begin
   grant1 <= 1; grant2 <= 0; grant3 <= 0;
   end else if (req2) begin
   grant1 <= 0; grant2 <= 1; grant3 <= 0;
   end else if (req3) begin
   grant1 <= 0; grant2 <= 0; grant3 <= 1;
    end else begin
    grant1 <= 0; grant2 <= 0; grant3 <= 0;
     end
    end
  end
endmodule

///testbench

module fixed_priority_arbiter_tb;

  // Testbench signals
  reg clk;
  reg reset;
  reg req1, req2, req3;
  wire grant1, grant2, grant3;

  // Instantiate the DUT (Design Under Test)
  fixed_priority_arbiter dut (
    .clk(clk),
    .reset(reset),
    .req1(req1),
    .req2(req2),
    .req3(req3),
    .grant1(grant1),
    .grant2(grant2),
    .grant3(grant3)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock (10ns period)
  end

  // Stimulus block
  initial begin
    // Initialize signals
    reset = 1;
    req1 = 0; req2 = 0; req3 = 0;

    // Apply reset
    #10;
    reset = 0;

    // Test Case 1: No requests
    #10;
    $display("Time=%0t | No requests | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Test Case 2: Request from req3
    req3 = 1;
    #10;
    $display("Time=%0t | req3=1       | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Test Case 3: Request from req2 (higher priority)
    req2 = 1;
    #10;
    $display("Time=%0t | req2=1, req3=1 | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Test Case 4: Request from req1 (highest priority)
    req1 = 1;
    #10;
    $display("Time=%0t | req1=1, req2=1, req3=1 | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Test Case 5: Deassert req1, should grant req2
    req1 = 0;
    #10;
    $display("Time=%0t | req2=1, req3=1 | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Test Case 6: Deassert req2, should grant req3
    req2 = 0;
    #10;
    $display("Time=%0t | req3=1 | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Test Case 7: Deassert all requests
    req3 = 0;
    #10;
    $display("Time=%0t | No requests | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Test Case 8: Apply reset again
    reset = 1;
    #10;
    reset = 0;
    #10;
    $display("Time=%0t | Reset applied | grant1=%b grant2=%b grant3=%b", $time, grant1, grant2, grant3);

    // Finish simulation
    $finish;
  end

  // Monitor block (optional, for live observation)
  initial begin
    $monitor("Time=%0t | reset=%b | req1=%b req2=%b req3=%b | grant1=%b grant2=%b grant3=%b",
              $time, reset, req1, req2, req3, grant1, grant2, grant3);
  end

endmodule



