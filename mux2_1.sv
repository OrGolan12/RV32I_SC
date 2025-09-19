module mux2_1(
    input [31:0] a,
    input [31:0] b,
    input s,
    output [31:0] y
);

    assign y = (s) ? b : a;

endmodule
