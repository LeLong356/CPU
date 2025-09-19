module PC (
        input logic clk, rst, load,
        input logic [4:0] data_in,
        output logic [4:0] pc_count
);
    logic [4:0] next ;
    logic [4:0] nor_pc ;
    assign next = pc_count + 5'b00001 ;
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst) pc_count <= 5'b0 ;
        else
        begin
            nor_pc <= next ;
        end
    end
    mux_parameter #(.WIDTH(5)) test(.d0(nor_pc), .d1(data_in), .control(load), .y(pc_count)) ;
endmodule
