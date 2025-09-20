module ALU (
    input  logic [7:0] rs1, rs2,
    input  logic [2:0] opcode,
    output logic [7:0] rd,
    output logic      is_zero
);

    always_comb begin
        case (opcode)
        3'b010: alu_out = in_a + in_b;
        3'b011: alu_out = in_a & in_b;
        3'b100: alu_out = in_a ^ in_b;
        3'b101: alu_out = in_b;
        default : alu_out = in_a;
        endcase
    end

    assign is_zero = (inA == 8'b0);

endmodule
