module IF_ID (
    input logic clk,
    input logic rst,
    input logic [7:0] ins,
    output logic [4:0] ins_out,
    output logic [2:0] control_in
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            ins_out <= 8'b0;
        end else begin
            ins_out <= ins[4:0];
            control_in <= ins[7:5];
        end
    end
endmodule

