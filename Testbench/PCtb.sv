
module PC_tb;

  logic clk;
  logic rst;
  logic load;
  logic en;
  logic [4:0] data_in;
  logic [4:0] pc_count;

  // DUT instantiation
  PC dut (
    .clk      (clk),
    .rst      (rst),
    .load     (load),
    .en       (en),
    .data_in  (data_in),
    .pc_count (pc_count)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;   // 10ns period
  end

  // Monitor
  initial begin
    $monitor("t=%0t | rst=%b load=%b data_in=%0d pc_count=%0d",
              $time, rst, load, data_in, pc_count);
  end

  // Test sequence
  initial begin
    // Init
    rst = 1; load = 0; data_in = 5'd0; en =1;
    @(posedge clk);
    rst = 0;

    // Check auto increment
    repeat (3) @(posedge clk);

    // Load a value
    load = 1; data_in = 5'd10;
    @(posedge clk);

    // Release load, should increment from 10
    load = 0;
    repeat (5) @(posedge clk);

    // Load another value
    load = 1; data_in = 5'd25;
    @(posedge clk);

    // Increment more
    load = 0;
    repeat (5) @(posedge clk);

    // Reset again
    rst = 1; @(posedge clk);
    rst = 0; @(posedge clk);

    $display("TEST FINISHED");
    $finish;
  end

endmodule
