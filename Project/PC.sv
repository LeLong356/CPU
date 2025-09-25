module PC (
        input logic clk, rst, load, en,
        input logic [4:0] data_in,
        output logic [4:0] pc_count
);
    always_ff @(posedge clk, posedge rst)
    begin
        if(rst) pc_count <= 5'b0 ;
        else
        begin
            if(en)
                begin
                        if(load) pc_count <= data_in ;
                        else pc_count <= pc_count + 1 ;
                end
        end
    end
endmodule
