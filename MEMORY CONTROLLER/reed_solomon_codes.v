module reed_solomon_encoder (
    input [7:0] data_in,  // 8-bit data
    output [11:0] code_out // 8 data bits + 4 parity bits
);
    reg [3:0] parity; // Parity bits
    always @(*) begin
        // Simplified parity calculation (example polynomial)
        parity[0] = data_in[0] ^ data_in[1] ^ data_in[2];
        parity[1] = data_in[1] ^ data_in[3] ^ data_in[4];
        parity[2] = data_in[2] ^ data_in[5] ^ data_in[6];
        parity[3] = data_in[3] ^ data_in[6] ^ data_in[7];
    end
   assign code_out = {data_in, parity};
endmodule

module reed_solomon_decoder (
    input [11:0] code_in,  // 12-bit received code
    output [7:0] data_out, // Original data
    output reg error       // Error flag
);
    reg [3:0] syndrome; // Error-checking syndrome
    always @(*) begin
        // Simple syndrome computation (example polynomial)
        syndrome[0] = code_in[8] ^ code_in[0] ^ code_in[1] ^ code_in[2];
        syndrome[1] = code_in[9] ^ code_in[1] ^ code_in[3] ^ code_in[4];
        syndrome[2] = code_in[10] ^ code_in[2] ^ code_in[5] ^ code_in[6];
        syndrome[3] = code_in[11] ^ code_in[3] ^ code_in[6] ^ code_in[7];
        error = (syndrome != 4'b0000); // Flag error if syndrome is non-zero
    end
    assign data_out = code_in[11:4]; // Extract original data
endmodule



//testbench
`timescale 1ns / 1ps

module reed_solomon_tb;

    // Testbench signals
    reg  [7:0] data_in;
    wire [11:0] code_out;

    reg  [11:0] code_in;
    wire [7:0] data_out;
    wire error;

    // Instantiate the encoder
    reed_solomon_encoder uut_encoder (
        .data_in(data_in),
        .code_out(code_out)
    );

    // Instantiate the decoder
    reed_solomon_decoder uut_decoder (
        .code_in(code_in),
        .data_out(data_out),
        .error(error)
    );

    // Task to run one test
    task run_test;
        input [7:0] input_data;
        input integer error_bit_pos;  // -1 for no error, 0-11 for error position
        begin
            $display("==========================================================");
            $display("Input Data         = %b", input_data);

            // Send input data to encoder
            data_in = input_data;
            #10; // Wait for encoder to generate code_out

            // Pass encoded data to decoder
            code_in = code_out;

            // Inject error if error_bit_pos is valid
            if (error_bit_pos >= 0 && error_bit_pos <= 11) begin
                $display("Injecting error at bit position %0d", error_bit_pos);
                code_in[error_bit_pos] = ~code_in[error_bit_pos];
            end else begin
                $display("No error injection");
            end

            #10; // Wait for decoder to process

            // Display results
            $display("Encoded Code      = %b", code_out);
            $display("Received Code     = %b", code_in);
            $display("Decoded Data      = %b", data_out);
            $display("Error Detected    = %b", error);
            $display("==========================================================\n");
        end
    endtask

    // Testbench stimulus
    initial begin
        $display("******** Reed Solomon Encoder/Decoder Testbench ********");

        // Test with no error
        run_test(8'b10101010, -1);
        run_test(8'b11110000, -1);
        run_test(8'b00001111, -1);
        run_test(8'b11001100, -1);

        // Test with injected single-bit errors
        run_test(8'b10101010, 0);
        run_test(8'b10101010, 5);
        run_test(8'b10101010, 8);
        run_test(8'b10101010, 11);

        // Finish simulation
        $display("******** Testbench Finished ********");
        $finish;
    end

endmodule

