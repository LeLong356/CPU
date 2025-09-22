module RST (
        input logic clk, rst,
        input logic [7:0] data_in,
        input logic load,
        output logic [7:0] data_out
);
        always_ff @(posedge clk)begin
                if (rst)
                data_out <= 8'b0;
                else if(load)
                data_out <= data_in;
        end
endmodule
