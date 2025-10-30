module ALU (
    input logic [7:0] rs1, rs2,
    input logic [2:0] opcode,
    output logic [7:0] rd,
    output logic is_zero,
    output logic flag
);
    logic [7:0] lut [0:7];
    always_comb begin
                is_zero = !(|rs1) ;
                lut[0] = rs1;
                lut[1] = rs1;
                lut[2] = rs1 + rs2; // 010
                lut[3] = rs1 & rs2; //011
                lut[4] = rs1 ^ rs2; //100
                lut[5] = rs2;//101
                lut[6] = rs1;
                lut[7] = rs1;
                rd = lut[opcode];
            end
endmodule
