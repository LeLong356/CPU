module RST(
    input logic clk,
    input logic [7:0] data_in,
    input logic rst,
    input logic load,
    output logic [7:0] data_out
);
    always_ff @(posedge clk)begin
        if(rst) begin 
            data_out <= 8'b0;
        end
        else if(load) begin
            data_out <= data_in;
        end
    end

endmodule
