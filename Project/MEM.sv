module MEM (
    input  logic       clk,    
    input  logic       en,     
    input  logic       we,    
    input  logic [4:0] addr,   
    input  logic [7:0] din,    
    output logic [7:0] dout    
);

    
    logic [7:0] mem [0:31];

    always_ff @(posedge clk) begin
        if (en) begin
            if (we) begin
                mem[addr] <= din;
            end else begin
                dout <= mem[addr];
            end
        end
    end

endmodule

