module RSTtb;

  logic  clk  ;
  logic  rst  ;
  logic  load ;
  logic  [7:0] data_in;
  logic [7:0] data_out;

  RST register_inst
   ( 
    .clk      ( clk      ),
    .rst      ( rst      ),
    .load     ( load     ),
    .data_in  ( data_in  ),
    .data_out ( data_out ) 
   );

  task automatic check(input [7:0] exp_out);
    if (data_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d rst=%b load=%b data_in=%b data_out=%b",
                $time, rst, load, data_in, data_out);
      $display("data_out should be %b", exp_out);
      $finish;
    end
   else begin
      $display("At time %0d rst=%b load=%b data_in=%b data_out=%b",
                $time, rst, load, data_in, data_out);
   end
  endtask


  initial repeat (5) begin #5 clk=1; #5 clk=0; end

  initial @(negedge clk) begin
    rst=0; load=1; data_in=8'h55; @(negedge clk) check (8'h55);
    rst=0; load=1; data_in=8'hAA; @(negedge clk) check (8'hAA);
    rst=0; load=1; data_in=8'hFF; @(negedge clk) check (8'hFF);
    rst=1; load=1; data_in=8'hFF; @(negedge clk) check (8'h00);
    $display("TEST PASSED");
    $finish;
  end

endmodule