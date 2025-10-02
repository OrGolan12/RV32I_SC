 module rv32i_sc(
    input logic clk, rst_n,
    input logic [31:0] ReadData,
    input logic [31:0] instr,
    output logic [31:0] PC,
    output logic MemWrite,
    output logic [31:0] ALUResult, WriteData
);

    logic ALUSrc, RegWrite, Jump, Zero, NEG, NEGU;
    logic [1:0] ResultSrc;
    logic [2:0] ImmSrc, LoadExtSrc;
    logic [3:0] ALUControl;
    logic PCSrc;

    controller c(.opcode(instr[6:0]), .funct3(instr[14:12]), .funct7_5(instr[30]), .Zero(Zero),
                .ResultSrc(ResultSrc), .MemWrite(MemWrite), .PCSrc(PCSrc), .ALUSrc(ALUSrc),
                .RegWrite(RegWrite), .ImmSrc(ImmSrc), .ALUControl(ALUControl), .LoadExtSrc(LoadExtSrc), .NEG(NEG), .NEGU(NEGU));

    datapath dp(.clk(clk), .rst_n(rst_n), .ResultSrc(ResultSrc), .PCSrc(PCSrc), .ALUSrc(ALUSrc),
                .RegWrite(RegWrite), .ImmSrc(ImmSrc),
                .ALUControl(ALUControl), .Zero(Zero), .PC(PC), .instr(instr), .ALUResult(ALUResult),
                .WriteData(WriteData), .ReadData(ReadData), .LoadExtSrc(LoadExtSrc), .NEG(NEG), .NEGU(NEGU));

endmodule
