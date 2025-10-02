module datapath(
    input clk,
    input rst_n,
    input logic [31:0] instr,
    input logic RegWrite,
    input logic [2:0] ImmSrc,
    input logic ALUSrc,
    input logic [1:0] ResultSrc,
    input logic PCSrc,
    input logic [31:0] ReadData,
    input logic [3:0] ALUControl,
    input logic [2:0] LoadExtSrc,
    output logic [31:0] PC,
    output logic Zero,
    output logic NEGU,
    output logic NEG,
    output logic [31:0] ALUResult,
    output logic [31:0] WriteData
);

    logic [31:0] SrcA, SrcB, immext, PCTarget, PCPlus4, PCNext, Result, DataExt;
    adder mux_PCPlus4 (.a(PC), .b(32'b100), .y(PCPlus4));
    adder mux_PCTarget (.a(PC), .b(immext), .y(PCTarget));

    imm_extend ImmExt (.in(instr[31:7]), .ImmSrc(ImmSrc), .ImmExt(immext));

    regfile rf (.clk(clk), .RegWrite(RegWrite), .a1(instr[19:15]), .a2(instr[24:20]), .a3(instr[11:7]), .wd3(Result), .rd1(SrcA), .rd2(WriteData));

    ff_r PC_Next_Reg (.clk(clk), .rst_n(rst_n), .d(PCNext), .q(PC));
    mux2_1 mux_SrcB (.a(WriteData), .b(immext), .s(ALUSrc), .y(SrcB));
    mux4_1 mux_Result (.a(ALUResult), .b(DataExt), .c(PCPlus4), .d(immext), .s(ResultSrc), .y(Result));
    mux2_1 mux_PCNext (.a(PCPlus4), .b(PCTarget), .s(PCSrc), .y(PCNext));

    alu alu (.a(SrcA), .b(SrcB), .ALUControl(ALUControl), .y(ALUResult), .Zero(Zero), .NEG(NEG), .NEGU(NEGU));
    load_extender le (.ReadData(ReadData), .offset(ALUResult[1:0]), .LoadExtSrc(LoadExtSrc), .DataExt(DataExt));

endmodule
