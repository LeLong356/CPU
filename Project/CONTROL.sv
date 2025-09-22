module CONTROL (
        input [2:0] opcode,
        input logic clk, rst,
        output logic pc_load, pc_en,
        output logic alu_en,
        output logic accumulator_load, accumulator_control,
        output logic mem_en, mem_we
);
    always_ff @(posedge clk)
    begin
        if(rst)
        begin
            pc_load <= 0 ; pc_en <= 1 ; alu_en <= 0 ; accumulator_control <= 0 ;
            ccumulator_control <= 0 ; mem_en <= 0 ; mem_we <= 0 ;

        end
        else
        begin
            case (opcode)
            3'b000 :    begin
                            pc_load <= 0 ; pc_en <= 0 ; alu_en <= 0 ; accumulator_control <= 0 ;
                            accumulator_load <= 0 ; mem_en <= 0 ; mem_we <= 0 ;
                        end
            3'b001 :    begin
                            pc_load <= 1 ; pc_en <= 0 ; alu_en <= 0 ; accumulator_control <= 0 ;
                            accumulator_load <= 0 ; mem_en <= 0 ; mem_we <= 0 ;
                        end
            3'b010 :    begin
                            pc_load <= 0 ; pc_en <= 1 ; alu_en <= 1 ; accumulator_control <= 0 ;
                            accumulator_load <= 1 ; mem_en <= 1 ; mem_we <= 0 ;
                        end
            3'b011 :    begin
                            pc_load <= 0 ; pc_en <= 1 ; alu_en <= 1 ; accumulator_control <= 0 ;
                            accumulator_load <= 1 ; mem_en <= 1 ; mem_we <= 0 ;
                        end
            3'b100 :    begin
                            pc_load <= 0 ; pc_en <= 1 ; alu_en <= 1 ; accumulator_control <= 0 ;
                            accumulator_load <= 1 ; mem_en <= 1 ; mem_we <= 0 ;
                        end
            3'b101 :    begin
                            pc_load <= 0 ; pc_en <= 1 ; alu_en <= 0 ; accumulator_control <= 1 ;
                            accumulator_load <= 1 ; mem_en <= 1 ; mem_we <= 0 ;
                        end
            3'b110 :    begin
                            pc_load <= 0 ; pc_en <= 1 ; alu_en <= 0 ; accumulator_control <= 1 ;
                            accumulator_load <= 0 ; mem_en <= 1 ; mem_we <= 1 ;
                        end
            3'b111 :    begin
                            pc_load <= 1 ; pc_en <= 0 ; alu_en <= 0 ; accumulator_control <= 0 ;
                            accumulator_load <= 0 ; mem_en <= 0 ; mem_we <= 0 ;
                        end
            endcase
        end
    end
endmodule
