module controller(
    input [6:0] opcode,
    input [2:0] funct3,
    input funct7_5,
    input zero,
    output logic RegWrite,
    output logic [1:0] ImmSrc,
    output logic ALUSrc,
    output logic MemWrite,
    output logic [1:0] ResultSrc,
    output logic PCSrc,
    output [2:0] ALUControl
);
    logic Branch;
    logic Jump;
    logic [1:0] ALUOp;


    main_decoder md (.opcode(opcode),.zero(zero), .RegWrite(RegWrite), .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc), .MemWrite(MemWrite), .ResultSrc(ResultSrc), .ALUOp(ALUOp), .Jump(Jump));

    alu_decoder ad (.ALUOp(ALUOp), .funct3(funct3), .op5(opcode[5]), .funct7_5(funct7_5),
     .ALUControl(ALUControl));

    assign PCSrc = ((Branch & Zero) | Jump);

endmodule
