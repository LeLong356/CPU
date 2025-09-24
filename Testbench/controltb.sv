`timescale 1ns/1ps

module control_tb;

    logic clk, rst;
    logic [2:0] opcode;
    logic is_zero;

    logic pc_load, pc_en, halt, jmp;
    logic accumulator_load, accumulator_control;
    logic memIns_en, memDa_en, memDa_we;

    // DUT
    CONTROL dut (
        .opcode(opcode),
        .clk(clk),
        .rst(rst),
        .is_zero(is_zero),
        .pc_load(pc_load),
        .pc_en(pc_en),
        .halt(halt),
        .jmp(jmp),
        .accumulator_load(accumulator_load),
        .accumulator_control(accumulator_control),
        .memIns_en(memIns_en),
        .memDa_en(memDa_en),
        .memDa_we(memDa_we)
    );

    // clock
    always #5 clk = ~clk;

    initial begin
        // init
        clk = 0; rst = 1; opcode = 3'b000; is_zero = 0;
        repeat (2) @(posedge clk); // giữ reset vài chu kỳ
        rst = 0;

        // chạy thử vài opcode
        run_opcode(3'b000);//Halt
        rst = 1; #10;
        rst = 0; 
                       
        run_opcode(3'b010);  // SKZ
        run_opcode(3'b101); // ví dụ
        run_opcode(3'b111);// ví dụ

        $display("DONE SIMULATION");
        $finish;
    end

    task run_opcode(input [2:0] op);
        begin
            opcode = op;
            repeat (5) begin
                @(posedge clk);
                $display("t=%0t state=%0d opcode=%0b",
                         $time, dut.state, opcode);
            end
        end
    endtask

endmodule
