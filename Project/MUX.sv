module mux_parameter
            #(parameter int WIDTH = 5)
            (
              input logic [WIDTH-1:0] d0, d1,
              input logic control,
              output logic [WIDTH-1:0] y
            );
    assign y = control ? d1 : d0 ;
endmodule
