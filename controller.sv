module controller(
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic funct7_5,
    input logic Zero,
    output logic RegWrite,
    output logic [1:0] ImmSrc,
    output logic ALUSrc,
    output logic MemWrite,
    output logic [1:0] ResultSrc,
    output logic PCSrc,
    output logic [3:0] ALUControl
);
    logic Branch;
    logic Jump;
    logic [1:0] ALUOp;

    logic Branch_Taken;

    main_decoder md (.opcode(opcode), .RegWrite(RegWrite), .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc), .MemWrite(MemWrite), .ResultSrc(ResultSrc), .ALUOp(ALUOp), .Jump(Jump), .Branch(Branch));

    alu_decoder ad (.ALUOp(ALUOp), .funct3(funct3), .op5(opcode[5]), .funct7_5(funct7_5),
     .ALUControl(ALUControl));

    assign Branch_Taken = Zero ^ funct3[0];
    assign PCSrc = ((Branch_Taken & Branch) | Jump);

endmodule
