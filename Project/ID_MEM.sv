module ID_MEM(
    input logic clk,
    input logic rst,
    input logic [2:0] opcode,
    input logic mem_rd, mem_we, acc_we, acc_control,
    input logic [4:0] addr,
    output logic mem_rd_out, mem_we_out, acc_we_out, acc_control_out,
    output logic [2:0] opcode_out,
    output logic [4:0] addr_out
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            mem_rd_out <= 1'b0;
            mem_we_out <= 1'b0;
            acc_we_out <= 1'b0;
            acc_control_out <= 1'b0;
            opcode_out <= 3'b0;
            addr_out <= 5'b0;
        end else begin
            addr_out <= addr;
            opcode_out <= opcode;
            mem_rd_out <= mem_rd;
            mem_we_out <= mem_we;
            acc_we_out <= acc_we;
            acc_control_out <= acc_control;
        end
    end
endmodule