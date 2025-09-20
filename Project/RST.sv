module Acc_reg (
        input logic clk, rst,
        input logic [7:0] data_mem, data_alu,
        input logic load, control,
        output logic [7:0] data_out
);
        always_ff @(posedge clk & posedge rst)begin
                if (rst)
                data_out <= 8'b0;
                else if(load)
                data_out <= control ? data_mem : data_alu;
        end
endmodule
