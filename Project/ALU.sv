module ALU (
    input logic [7:0] rs1, rs2,
    input logic [2:0] opcode,
    input logic en,
    output logic [7:0] rd,
    output logic is_zero
);
    logic [7:0] lut [0:7];
    always_comb begin
        begin
            if(en)
            begin
                is_zero = !(|rs1) ;
                lut[2] = rs1 + rs2; // 010
                lut[3] = rs1 & rs2; //011
                lut[4] = rs1 ^ rs2; //100
                rd = lut[opcode];
            end
        end
    end
endmodule
