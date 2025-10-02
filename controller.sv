module controller(
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic funct7_5,
    input logic Zero,
    input logic NEG,
    input logic NEGU,
    output logic RegWrite,
    output logic [2:0] ImmSrc,
    output logic ALUSrc,
    output logic MemWrite,
    output logic [1:0] ResultSrc,
    output logic PCSrc,
    output logic [3:0] ALUControl,
    output logic [2:0] LoadExtSrc
);
    logic Branch;
    logic Jump;
    logic [1:0] ALUOp;
    logic Branch_Taken;

    main_decoder md (.opcode(opcode), .RegWrite(RegWrite), .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc), .MemWrite(MemWrite), .ResultSrc(ResultSrc), .ALUOp(ALUOp), .Jump(Jump), .Branch(Branch));

    alu_decoder ad (.ALUOp(ALUOp), .funct3(funct3), .op5(opcode[5]), .funct7_5(funct7_5),
     .ALUControl(ALUControl));

    branch_logic bl (.funct3(funct3), .Zero(Zero), .NEG(NEG), .NEGU(NEGU), .Branch_Taken(Branch_Taken));

    assign PCSrc = ((Branch_Taken & Branch) | Jump);
    assign LoadExtSrc = funct3;

endmodule
