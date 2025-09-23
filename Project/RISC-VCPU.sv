module RISC_VCPU (
        input logic clk, rst,
        output logic HALT
);
    logic pc_load, pc_en, skz_addr, jmp_addr, jmp_control ;
    logic [4:0] pc_addr, addr_in;
    logic accumulator_control, accumulator_load ;
    logic memIns_en, memDa_en, memDa_we ;
    logic [7:0] acc_in, acc_out, alu_out, memDa_out, zero, ins;

    PC counter (.clk(clk), .rst(rst), .load(pc_load), .en(pc_en),
                    .data_in(addr_in), .pc_count(pc_addr)) ;

    MEM MemIns (.clk(clk), .en(memIns_en), .we('0), .addr(pc_addr),
                    .din('0), .dout(ins)) ;

    CONTROL control_signal (.opcode(ins[7:5]), .clk(clk), .rst(rst), .is_zero(zero),
                    .pc_load(pc_load), .pc_en(pc_en), .halt(HALT), .jmp(jmp_control),
                    .accumulator_load(accumulator_load), .accumulator_control(accumulator_control),
                    .memIns_en(memIns_en), .memDa_en(memDa_en), .memDa_we(memDa_we)) ;

    MEM MemData (.clk(clk), .en(memDa_en), .we(memDa_we),
                .addr(ins[4:0]), .din(acc_out), .dout(memDa_out)) ;

    ALU alu (.rs1(acc_out), .rs2(memDa_out), .rd(alu_out), .opcode(ins[7:5]), .is_zero(zero)) ;

    mux_parameter #(.WIDTH(8)) muxData (.d0(alu_out), .d1(memDa_out),
                                        .control(accumulator_control), .y(acc_in)) ;

    RST accumulator (.clk(clk), .rst(rst), .load(accumulator_load),
                            .data_in(acc_in), .data_out(acc_out)) ;

  prefixadder SKZ (.A(pc_addr), .B(5'b00010), .Cin(1'b0),
                        .Sum(skz_addr), .Cout()) ;

    mux_parameter #(.WIDTH(5)) muxAddr (.d0(skz_addr), .d1(ins[4:0]),
                                        .control(jmp_control), .y(addr_in)) ;
endmodule
