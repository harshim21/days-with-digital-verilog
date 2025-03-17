module hamming_encoder (
    input [3:0] data_in,  // 4 data bits
    output [6:0] code_out // 7 Hamming code bits
);
assign code_out[0] = data_in[0] ^ data_in[1] ^ data_in[3]; // P1
assign code_out[1] = data_in[0] ^ data_in[2] ^ data_in[3]; // P2
assign code_out[2] = data_in[0];                                         // D1
assign code_out[3] = data_in[1] ^ data_in[2] ^ data_in[3]; // P4
assign code_out[4] = data_in[1];                                         // D2
assign code_out[5] = data_in[2];                                         // D3
assign code_out[6] = data_in[3];                                         // D4  
endmodule

module hamming_decoder (
    input [6:0] code_in,   // 7 Hamming code bits
    output [3:0] data_out, // 4 data bits
    output reg error       // Error flag
);
    wire p1, p2, p4;
    assign p1 = code_in[0] ^ code_in[2] ^ code_in[4] ^ code_in[6];
    assign p2 = code_in[1] ^ code_in[2] ^ code_in[5] ^ code_in[6];
    assign p4 = code_in[3] ^ code_in[4] ^ code_in[5] ^ code_in[6];
  wire [2:0] syndrome = {p4, p2, p1}; // Error location index
 always @(*) 
   begin
     if (syndrome != 3'b000) error = 1; // Error detected
     else error = 0;
   end 
assign data_out ={code_in[6], code_in[5],code_in[4],code_in[2]};
endmodule


///testbench

`timescale 1ns / 1ps

module hamming_code_tb;

    // Inputs to encoder
    reg [3:0] data_in;

    // Outputs from encoder
    wire [6:0] code_out;

    // Inputs to decoder
    reg [6:0] code_in;

    // Outputs from decoder
    wire [3:0] data_out;
    wire error;

    // Instantiate Encoder
    hamming_encoder encoder_inst (
        .data_in(data_in),
        .code_out(code_out)
    );

    // Instantiate Decoder
    hamming_decoder decoder_inst (
        .code_in(code_in),
        .data_out(data_out),
        .error(error)
    );

    // Task for testing encoding/decoding
    task test_case(input [3:0] test_data, input integer error_bit);
        begin
            // Apply input data
            data_in = test_data;
            #10; // wait for encoder outputs

            // Transmit code (optionally inject error)
            code_in = code_out;
            
            if (error_bit >= 0 && error_bit <= 6) begin
                $display("\nInjecting error at bit position %0d", error_bit);
                code_in[error_bit] = ~code_in[error_bit];
            end

            #10; // wait for decoder outputs

            // Display results
            $display("Input Data       : %b", test_data);
            $display("Encoded Code     : %b", code_out);
            $display("Received Code    : %b", code_in);
            $display("Decoded Data     : %b", data_out);
            $display("Error Detected   : %b", error);
        end
    endtask

    // Stimulus
    initial begin
        $display("\n--- Hamming Encoder & Decoder Testbench ---");

        // No error test cases
        test_case(4'b0000, -1);
        test_case(4'b1010, -1);
        test_case(4'b1101, -1);
        test_case(4'b1111, -1);

        // Single-bit error injection test cases
        test_case(4'b1010, 0);  // Flip bit 0 (P1)
        test_case(4'b1010, 1);  // Flip bit 1 (P2)
        test_case(4'b1010, 2);  // Flip bit 2 (D1)
        test_case(4'b1010, 3);  // Flip bit 3 (P4)
        test_case(4'b1010, 4);  // Flip bit 4 (D2)
        test_case(4'b1010, 5);  // Flip bit 5 (D3)
        test_case(4'b1010, 6);  // Flip bit 6 (D4)

        $display("\n--- End of Simulation ---");
        $finish;
    end

endmodule
