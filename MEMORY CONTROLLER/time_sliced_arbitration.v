module time_sliced_arbiter (
    input wire clk, reset,
    input wire req1, req2, req3,
    output reg grant1, grant2, grant3
);
    reg [3:0] counter; 
// Time slice counter
    reg [1:0] state;
 always @(posedge clk or posedge reset) begin  if (reset) begin
            counter <= 0;
            state   <= 2'b00;
            grant1  <= 0;
            grant2  <= 0;
            grant3  <= 0;
 end else begin
            counter <= counter + 1;
   if (counter == 4'b1111) begin
      // Change every 16 cycles
             counter <= 0;
             state <= state + 1;
   end
   case (state)
2'b00: begin grant1 <= req1; grant2 <= 0;      grant3 <= 0; end
2'b01: begin grant1 <= 0; grant2 <= req2; grant3 <= 0; end
2'b10: begin grant1 <= 0; grant2 <= 0;       grant3 <= req3; end
default: state <= 2'b00;
   endcase
end
end
endmodule



//testbench

`timescale 1ns/1ps

module time_sliced_arbiter_tb;

  // Testbench signals
  reg clk;
  reg reset;
  reg req1, req2, req3;
  wire grant1, grant2, grant3;

  // Instantiate the DUT
  time_sliced_arbiter dut (
    .clk(clk),
    .reset(reset),
    .req1(req1),
    .req2(req2),
    .req3(req3),
    .grant1(grant1),
    .grant2(grant2),
    .grant3(grant3)
  );

  // Clock generation (10ns period)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    // Initialize
    reset = 1;
    req1 = 0;
    req2 = 0;
    req3 = 0;

    // Apply reset
    #10;
    reset = 0;

    // Test Case 1: Assert req1, req2, req3 at different times
    #10 req1 = 1; req2 = 0; req3 = 0; // Only req1 active
    #160; // Wait for a couple of state changes (each state lasts 16 cycles)

    req1 = 0; req2 = 1; req3 = 0; // Only req2 active
    #160;

    req1 = 0; req2 = 0; req3 = 1; // Only req3 active
    #160;

    // Test Case 2: All requests active
    req1 = 1; req2 = 1; req3 = 1;
    #160;

    // Test Case 3: No requests active
    req1 = 0; req2 = 0; req3 = 0;
    #80;

    // Apply reset again during operation
    reset = 1;
    #10;
    reset = 0;
    
    // Requests active again after reset
    req1 = 1; req2 = 1; req3 = 1;
    #160;

    // Finish simulation
    $finish;
  end

  // Monitor block
  initial begin
    $monitor("Time=%0t | reset=%b | req1=%b req2=%b req3=%b | grant1=%b grant2=%b grant3=%b",
              $time, reset, req1, req2, req3, grant1, grant2, grant3);
  end

endmodule
