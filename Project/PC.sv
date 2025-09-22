module PC (
        input logic clk, rst, load, en,
        input logic [4:0] data_in,
        output logic [4:0] pc_count
);
    logic [4:0] nor_pc ;
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst) pc_count <= 5'b0 ;
        else
        begin
            if(en)
            nor_pc <= pc_count + 5'b00001 ;
        end
    end
    mux_parameter #(.WIDTH(5)) test(.d0(nor_pc), .d1(data_in), .control(load), .y(pc_count)) ;
endmodule
