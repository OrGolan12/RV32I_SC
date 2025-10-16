module imm_extend (
    input  logic [31:7] in,
    input  logic [2:0]  ImmSrc,
    output logic [31:0] ImmExt
);
    wire [11:0] immI = in[31:20];
    wire [11:0] immS = {in[31:25], in[11:7]};
    wire [12:0] immB = {in[31], in[7], in[30:25], in[11:8], 1'b0};
    wire [20:0] immJ = {in[31], in[19:12], in[20], in[30:21], 1'b0};
    wire [19:0] immU = {in[31:12]};

    assign ImmExt =
        (ImmSrc == 3'b000) ? {{20{immI[11]}}, immI} :
        (ImmSrc == 3'b001) ? {{20{immS[11]}}, immS} :
        (ImmSrc == 3'b010) ? {{19{immB[12]}}, immB} :
        (ImmSrc == 3'b011) ? {{11{immJ[20]}}, immJ} :
                             {immU, 12'b0};

endmodule
