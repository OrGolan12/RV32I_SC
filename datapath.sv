module datapath(
    input clk,
    input rst_n,
    input [31:0] instr,
    input logic RegWrite,
    input logic [1:0] ImmSrc,
    input logic ALUSrc,
    input logic [1:0] ResultSrc,
    input logic PCSrc,
    input logic [31:0] ReadData,
    input logic [2:0] ALUControl,
    output [31:0] PC,
    output Zero,
    output [31:0] ALUResult,
    output [31:0] WriteData
);

    logic [31:0] SrcA, SrcB, ImmExt, PCTarget, PCPlus4, PCNext, Result;

    adder PC4 (.a(PC), .b(3'b100), .y(PCPlus4));
    adder PCTar (.a(PC), .b(ImmExt), .y(PCTarget));

    ImmExt ImmExt (.in(inst[31:7]), .ImmSrc(ImmSrc), .ImmExt(immExt));

    ff_r PCReg (.clk(clk), .rst_n(rst_n), .d(PCNext), .q(PC));
    mux2_1 mux_SrcB (.a(WriteData), .b(ImmExt), .s(ALUSrc), .y(SrcB));
    mux3_1 mux_Result (.a(ALUResult), .b(ReadData), .c(PCPlus4), .s(ResultSrc), .y(Result));
    mux2_1 mux_PCNext (.a(PCPlus4), .b(PCTarget), .s(PCSrc));

    alu alu (.a(SrcA), .b(SrcB), .ALUControl(ALUControl), .y(ALUResult));

endmodule
