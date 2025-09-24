module ALUtb;
  typedef enum logic [2:0] {
    PASS0 = 3'd0,
    PASS1 = 3'd1,
    ADD   = 3'd2,
    AND_  = 3'd3,
    XOR_  = 3'd4,
    PASSB = 3'd5,
    PASS6 = 3'd6,
    PASS7 = 3'd7
  } opcode_t;

  logic [2:0]       opcode;
  logic [7:0] in_a, in_b;
  logic             a_is_zero;
  logic en;
  logic [7:0] alu_out;

  // DUT instantiation
  ALU  alu_inst (
    .opcode    (opcode),
    .rs1      (in_a),
    .rs2      (in_b),
    .is_zero (a_is_zero),
    .rd   (alu_out)
  );

  // Expectation task
  task automatic check(input logic exp_zero,
                        input logic [7:0] exp_out);
    if (a_is_zero !== exp_zero || alu_out !== exp_out) begin
      $error("TEST FAILED at time %0t | opcode=%0d in_a=%h in_b=%h a_is_zero=%b alu_out=%h",
             $time, opcode, in_a, in_b, a_is_zero, alu_out);
      if (a_is_zero !== exp_zero)
        $error("Expected a_is_zero=%b, got %b", exp_zero, a_is_zero);
      if (alu_out !== exp_out)
        $error("Expected alu_out=%h, got %h", exp_out, alu_out);
      $finish;
    end
    else begin
      $display("PASS at time %0t | opcode=%0d in_a=%h in_b=%h a_is_zero=%b alu_out=%h",
               $time, opcode, in_a, in_b, a_is_zero, alu_out);
    end
  endtask

  // Test sequence
  initial begin
    opcode = PASS0;en  =1; in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'h42);
    opcode = PASS1;en=1; in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'h42);
    opcode = ADD;en=1;   in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'hC8);
    opcode = AND_;en=1;  in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'h02);
    opcode = XOR_;en=1;  in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'hC4);
    opcode = PASSB;en=1; in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'h86);
    opcode = PASS6;en=1; in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'h42);
    opcode = PASS7;en=1; in_a = 8'h42; in_b = 8'h86; #1 check(1'b0, 8'h42);
    opcode = PASS7;en=1; in_a = 8'h00; in_b = 8'h86; #1 check(1'b1, 8'h00);
    $display("ALL TESTS PASSED");
    $finish;
  end

endmodule
