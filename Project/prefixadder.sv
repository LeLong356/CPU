module prefixadder_8bit(
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic       Cin,
    output logic [7:0] Sum,
    output logic       Cout
);
    // Generate and Propagate signals
    logic [7:0] G0, P0;
    logic [7:0] C;

    assign G0 = A & B;
    assign P0 = A ^ B;

    assign C[0] = Cin;

    // -------- Level 1 --------
    logic [6:0] G1, P1;
    genvar i;
    generate
        for (i = 0; i < 7; i = i + 1) begin
            assign G1[i] = G0[i+1] | (P0[i+1] & G0[i]);
            assign P1[i] = P0[i+1] & P0[i];
        end
    endgenerate

    // -------- Level 2 --------
    logic [5:0] G2, P2;
    generate
        for (i = 0; i < 6; i = i + 1) begin
            assign G2[i] = G1[i+1] | (P1[i+1] & G1[i]);
            assign P2[i] = P1[i+1] & P1[i];
        end
    endgenerate

    // -------- Level 3 --------
    logic [3:0] G3, P3;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            assign G3[i] = G2[i+2] | (P2[i+2] & G2[i]);
            assign P3[i] = P2[i+2] & P2[i];
        end
    endgenerate

    // -------- Level 4 --------
    logic [1:0] G4, P4;
    assign G4[0] = G3[2] | (P3[2] & G2[0]);
    assign P4[0] = P3[2] & P2[0];
    assign G4[1] = G3[3] | (P3[3] & G2[1]);
    assign P4[1] = P3[3] & P2[1];

    // -------- Final Carry --------
    assign C[1] = G0[0] | (P0[0] & C[0]);
    assign C[2] = G1[0] | (P1[0] & C[0]);
    assign C[3] = G2[0] | (P2[0] & C[0]);
    assign C[4] = G3[0] | (P3[0] & C[0]);
    assign C[5] = G2[2] | (P2[2] & C[1]); // extra connections
    assign C[6] = G3[1] | (P3[1] & C[2]);
    assign C[7] = G4[0] | (P4[0] & C[0]);

    assign Cout = G4[1] | (P4[1] & C[0]);

    // -------- Sum --------
    assign Sum = C ^ P0;

endmodule

