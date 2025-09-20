module ALU (
        input logic [8:0] rs1, rs2,
        input logic [1:0] control,
        output logic [8:0] rd
);
    logic [7:0] a_nd, x_or, add ;

    assign a_nd = rs1 & rs2 ;
    assign x_or = rs1 ^ rs2 ;

    frefixadder_8bit adder (.A(rs1), .B(rs2), .cin(0), .G0(a_nd), .P0(x_or), .sum(add), .cout(0)) ;

    always_comb
    begin
        if(control[1] == 0) rd = x_or ;
        else if(control[0] == 0) rd = a_nd ;
        else rd = add ;
    end
endmodule
