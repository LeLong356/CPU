
module MEMtb;

  logic        clk;
  logic        en;
  logic        we;
  logic [4:0]  addr;
  logic [7:0]  din;
  logic [7:0]  dout;

  // DUT instantiation
  MEM memory_inst (
    .clk  (clk),
    .en   (en),
    .we   (we),
    .addr (addr),
    .din  (din),
    .dout (dout)
  );

  // Checker task
  task automatic check(input [7:0] exp_data);
    if (dout !== exp_data) begin
      $error("TEST FAILED at time %0t | addr=%0d dout=%h (expected %h)",
             $time, addr, dout, exp_data);
      $finish;
    end
    else begin
      $display("PASS at time %0t | addr=%0d dout=%h", $time, addr, dout);
    end
  endtask

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test sequence
  initial begin : TEST
    en = 1;

    // Write addr=0, data=8'hAA
    @(negedge clk);
    addr = 5'd0; din = 8'hAA; we = 1;
    @(negedge clk);

    // Write addr=1, data=8'h55
    addr = 5'd1; din = 8'h55; we = 1;
    @(negedge clk);

    // Read addr=0
    addr = 5'd0; we = 0;
    @(negedge clk);
    check(8'hAA);

    // Read addr=1
    addr = 5'd1; we = 0;
    @(negedge clk);
    check(8'h55);

    // Write ascending data to descending addresses
    $display("Writing ascending data to descending addresses");
    we = 1;
    for (int i = 31; i >= 0; i--) begin
      addr = i;
      din  = i;  // store i for simplicity
      @(negedge clk);
    end

    // Read back ascending data from descending addresses
    $display("Reading ascending data from descending addresses");
    we = 0;
    for (int i = 31; i >= 0; i--) begin
      addr = i;
      @(negedge clk);
      check(i);
    end

    $display("ALL TESTS PASSED");
    $finish;
  end

endmodule
