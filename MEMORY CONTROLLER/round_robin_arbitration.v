module round_robin_arbitration (
    input  wire clk,
    input  wire rst,
    input  wire [3:0] req,  // 4 request lines
    output reg  [3:0] grant // 4 grant lines
);  

    reg [1:0] pointer; // Tracks the current priority  

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pointer <= 2'b00;      // Reset the pointer 
            grant   <= 4'b0000;    // Reset all grants
        end else begin
            grant <= 4'b0000;      // Default: no grant 

            case (pointer)
                2'b00: 
                    if      (req[0]) grant <= 4'b0001;
                    else if (req[1]) grant <= 4'b0010;
                    else if (req[2]) grant <= 4'b0100;
                    else if (req[3]) grant <= 4'b1000;

                2'b01: 
                    if      (req[1]) grant <= 4'b0010;
                    else if (req[2]) grant <= 4'b0100;
                    else if (req[3]) grant <= 4'b1000;
                    else if (req[0]) grant <= 4'b0001;

                2'b10: 
                    if      (req[2]) grant <= 4'b0100;
                    else if (req[3]) grant <= 4'b1000;
                    else if (req[0]) grant <= 4'b0001;
                    else if (req[1]) grant <= 4'b0010;

                2'b11: 
                    if      (req[3]) grant <= 4'b1000;
                    else if (req[0]) grant <= 4'b0001;
                    else if (req[1]) grant <= 4'b0010;
                    else if (req[2]) grant <= 4'b0100;
            endcase

            // Update the pointer to rotate priorities
            if (|grant) begin // Only rotate if there was a grant
                pointer <= pointer + 2'b01;
            end
        end
    end
endmodule



//testbench
`timescale 1ns/1ps

module round_robin_arbitration_tb;

  // Testbench signals
  reg clk;
  reg rst;
  reg [3:0] req;
  wire [3:0] grant;

  // Instantiate the DUT (Design Under Test)
  round_robin_arbitration dut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .grant(grant)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns period clock
  end

  // Stimulus block
  initial begin
    // Initialize signals
    rst = 1;
    req = 4'b0000;

    // Apply reset
    #10;
    rst = 0;

    // Test Case 1: Single request from req[0]
    req = 4'b0001;
    #10;
    $display("Time=%0t | req=0001 | grant=%b", $time, grant);

    // Test Case 2: Multiple requests req[1] and req[2]
    req = 4'b0110;
    #10;
    $display("Time=%0t | req=0110 | grant=%b", $time, grant);

    #10;
    $display("Time=%0t | req=0110 | grant=%b", $time, grant);

    #10;
    $display("Time=%0t | req=0110 | grant=%b", $time, grant);

    #10;
    $display("Time=%0t | req=0110 | grant=%b", $time, grant);

    // Test Case 3: All requests active
    req = 4'b1111;
    repeat (8) begin
      #10;
      $display("Time=%0t | req=1111 | grant=%b", $time, grant);
    end

    // Test Case 4: No requests active
    req = 4'b0000;
    #10;
    $display("Time=%0t | req=0000 | grant=%b", $time, grant);

    // Test Case 5: Request from req[3] only
    req = 4'b1000;
    #10;
    $display("Time=%0t | req=1000 | grant=%b", $time, grant);

    // Reset again to see the pointer reset
    rst = 1;
    #10;
    rst = 0;
    req = 4'b1111; // All requests active after reset
    repeat (4) begin
      #10;
      $display("Time=%0t | req=1111 (after reset) | grant=%b", $time, grant);
    end

    $finish;
  end

  // Monitor block (optional, for live observation)
  initial begin
    $monitor("Time=%0t | rst=%b | req=%b | grant=%b", $time, rst, req, grant);
  end

endmodule
