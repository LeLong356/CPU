module CONTROL (
        input [2:0] opcode,
        input logic clk, rst,
        output logic pc_load, pc_en, halt,
        output logic accumulator_load, accumulator_control,
        output logic memIns_en, memDa_en, memDa_we,
        output logic jmp
);
    typedef enum logic [3:0] {
                                s0 = 0001, //fetch
                                s1 = 0010, //decode
                                s2 = 0100, //execute
                                s3 = 1000  //write back
                            } statetype_e ;
    statetype_e state, nextstate ;
    always_comb
    begin
        if(!halt)
        begin
            nextstate[0] = state[3] ;
            nextstate[1] = state[0] ;
            nextstate[2] = state[1] ;
            nextstate[3] = state[2] ;
        end
    end

    always_ff @(posedge clk)
    begin
        if(rst) state <= s0 ;
        else state <= nextstate ;
    end

    logic ACC_LOAD, STO, HALT, JMP, SKZ ;
    always_comb
    begin
        ACC_LOAD = (opcode == 2 | opcode == 3 | opcode == 4 | opcode == 5) ;
        ACC_MEM = (opcode == 5) ;
        STO = (opcode == 6) ;
        HALT = (opcode == 0) ;
        JMP = (opcode == 7) ;
        SKZ = (opcode == 2) ;
    end

    always_ff @(posedge clk)
    begin
        if(rst)
        begin
            pc_load <= 0 ; pc_en <= 1 ; halt <= 0 ;
            accumulator_control <= 0 ; accumulator_load <= 0 ;
            memIns_en <= 0 ; memDa_en <= 0 ; memDa_we <= 0 ;
        end
        else
        begin
            case (state)
            4'b0001 :    begin //Fetch
                            pc_load <= 0 ; pc_en <= 0 ; halt <= 0 ;
                            accumulator_control <= 0 ; accumulator_load <= 0 ;
                            memIns_en <= 1 ; memDa_en <= 0 ; memDa_we <= 0 ;
                        end
            4'b0010 :    begin //Decode
                            pc_load <= 0 ; pc_en <= 0 ; halt <= 0 ;
                            accumulator_control <= 0 ; accumulator_load <= 0 ;
                            memIns_en <= 1 ; memDa_en <= 1 ; memDa_we <= 0 ;
                        end
            4'b0100 :    begin //Execute
                            pc_load <= 0 ; pc_en <= 0 ; halt <= HALT ;
                            accumulator_control <= ACC_MEM ; accumulator_load <= ACC_LOAD ;
                            memIns_en <= 1 ; memDa_en <= 1 ; memDa_we <= STO ;
                        end
            4'b1000 :    begin //WriteBack
                            pc_load <= (JMP | SKZ) ; pc_en <= 1 ; halt <= 0 ;
                            accumulator_control <= 0 ; accumulator_load <= 0 ;
                            memIns_en <= 1 ; memDa_en <= 1 ; memDa_we <= 0 ;
                        end
            default :   begin // default <=> reset
                            pc_load <= 0 ; pc_en <= 1 ; halt <= 0 ;
                            accumulator_control <= 0 ; accumulator_load <= 0 ;
                            memIns_en <= 0 ; memDa_en <= 0 ; memDa_we <= 0 ;
                        end
            endcase
        end
    end
endmodule
