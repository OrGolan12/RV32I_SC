module imm_extend (
    input  logic [31:7] in,
    input  logic [1:0]  ImmSrc,
    output logic [31:0] ImmExt
);
    wire [11:0] immI = in[31:20];
    wire [11:0] immS = {in[31:25], in[11:7]};
    wire [12:0] immB = {in[31], in[7], in[30:25], in[11:8], 1'b0};
    wire [20:0] immJ = {in[31], in[19:12], in[20], in[30:21], 1'b0};

    assign ImmExt =
        (ImmSrc == 2'b00) ? {{20{immI[11]}}, immI} :
        (ImmSrc == 2'b01) ? {{20{immS[11]}}, immS} :
        (ImmSrc == 2'b10) ? {{19{immB[12]}}, immB} :
                            {{11{immJ[20]}}, immJ};
endmodule
