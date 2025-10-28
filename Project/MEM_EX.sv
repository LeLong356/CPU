module MEM_EX(
    input logic clk,
    input logic rst,
    input logic [7:0] data_in,
    input logic mem_we, acc_we, acc_control,
    input logic [2:0] opcode,
    output logic mem_we_out, acc_we_out, acc_control_out,
    output logic [7:0] data_out,
    output logic [2:0] opcode_out
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= 8'b0;
            mem_we_out <= 1'b0;
            acc_we_out <= 1'b0;
            acc_control_out <= 1'b0;
            opcode_out <= 3'b0;
        end else begin
            data_out <= data_in;
            mem_we_out <= mem_we;
            acc_we_out <= acc_we;
            acc_control_out <= acc_control;
            opcode_out <= opcode;
        end
    end
endmodule