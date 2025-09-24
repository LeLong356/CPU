`timescale 1ns/1ps

module cpu_tb;

    logic clk, rst;
    logic [7:0] last_pc;
    // Instance CPU
    RISC_VCPU dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock
    always #5 clk = ~clk;

    // Counters
    integer cycle_count;
    integer instr_count;

    // Đếm cycle và instruction
    always @(posedge clk) begin
        if (rst) begin
            cycle_count <= 0;
            instr_count <= 0;
        end else begin
            cycle_count <= cycle_count + 1;

            // Mỗi khi PC thay đổi → coi như fetch 1 instr
            if (dut.memIns_en) begin
                instr_count <= instr_count + 1;
            end
        end
    end

    // Test scenario
    initial begin
        // Nạp chương trình mẫu vào instruction memory
        dut.MemIns.mem[0] = 8'b10100101; // JMP giả định
        dut.MemIns.mem[1] = 8'b11100010; // NOP giả định
        dut.MemIns.mem[2] = 8'b00000000; // HLT giả định

        clk = 0;
        rst = 1;
        #20 rst = 0;

        // Giả sử chạy 50 chu kỳ
        #10000000;

        $display("Total cycles = %0d", cycle_count);
        $display("Instruction count = %0d", instr_count);
        if (instr_count > 0)
            $display("CPI = %f", cycle_count * 1.0 / instr_count);
        else
            $display("No instruction executed!");

        $finish;
    end

endmodule
