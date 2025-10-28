module EX_WB(
    input logic clk,
    input logic rst,
    input logic [7:0] alu_result_in, acc_in, data_in,
    input logic mem_we, acc_we, acc_control, 
    output logic [7:0] alu_result_out, data_out, acc_out,
    output logic mem_we_out, acc_we_out, acc_control_out
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            alu_result_out <= 8'b0;
            data_out <= 8'b0;
            acc_out <= 8'b0;
            mem_we_out <= 1'b0;
            acc_we_out <= 1'b0;
            acc_control_out <= 1'b0;
        end else begin
            alu_result_out <= alu_result_in;
            data_out <= data_in;
            acc_out <= acc_in;
            mem_we_out <= mem_we;
            acc_we_out <= acc_we;
            acc_control_out <= acc_control;
        end
    end
endmodule
