module CONTROL (
        input logic [2:0] opcode,
        input logic clk, rst,
        input logic is_zero,
        output logic pc_load, pc_en, halt,
        output logic accumulator_load, accumulator_control,
        output logic memIns_en, memDa_en, memDa_we,
        output logic jmp
);
    typedef enum logic [4:0] {
        s0 = 5'b00001, // reset
        s1 = 5'b00010, // fetch
        s2 = 5'b00100, // decode
        s3 = 5'b01000, // execute
        s4 = 5'b10000  // writeback
    } statetype_e;

    statetype_e state, nextstate;

    always_comb begin
    if (!halt) begin
        case (state)
            s0: nextstate = s1;
            s1: nextstate = s2;
            s2: nextstate = s3;
            s3: nextstate = s4;
            s4: nextstate = s0;
            default: nextstate = s0;
        endcase
    end else begin
        nextstate = state; // giữ nguyên khi halt
    end
end
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= s0;
        else
            state <= nextstate;
    end
    
    logic ACC_LOAD, ACC_MEM, STO, HALT, JMP, SKZ ;
    always_comb
    begin
        ACC_LOAD = (opcode == 2 | opcode == 3 | opcode == 4 | opcode == 5) ;
        ACC_MEM = (opcode == 5) ;
        STO = (opcode == 6) ;
        HALT = (opcode == 0) ;
        JMP = (opcode == 7) ;
        SKZ = (opcode == 2) ;
    end

    always_comb
    begin
           case (state)
            s1 :        begin //Fetch
                            pc_load = JMP | (SKZ & is_zero) ; pc_en = 0 ; halt = 0 ; jmp = JMP ;
                            accumulator_control = 0 ; accumulator_load = 0 ;
                            memIns_en = 1 ; memDa_en = 0 ; memDa_we = 0 ;
                        end
            s2 :        begin //Decode
                            pc_load = 0 ; pc_en = 0 ; halt = 0 ; jmp = JMP ;
                            accumulator_control = 0 ; accumulator_load = 0 ;
                            memIns_en = 0 ; memDa_en = 1 ; memDa_we = 0 ;
                        end
            s3 :        begin //Execute
                            pc_load = 0 ; pc_en = 0 ; halt = HALT ; jmp = JMP ;
                            accumulator_control = ACC_MEM ; accumulator_load = ACC_LOAD ;
                            memIns_en = 0 ; memDa_en = 0 ; memDa_we = STO ;
                        end
            s4 :        begin //WriteBack
                            pc_load = 0 ; pc_en = 1 ; halt = 0 ; jmp = JMP;
                            accumulator_control = 0 ; accumulator_load = 0 ;
                            memIns_en = 0 ; memDa_en = 0 ; memDa_we = 0 ;
                        end
            default:    begin
                            pc_load = 0 ; pc_en = 0 ; halt = 0 ; jmp = 0 ;
                            accumulator_control = 0 ; accumulator_load = 0 ;
                            memIns_en = 0 ; memDa_en = 0 ; memDa_we = 0 ;
                        end
            endcase
    end
endmodule
