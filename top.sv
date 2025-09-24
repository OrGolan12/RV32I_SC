module top( 
    input logic clk, rst_n,
    output logic [31:0] WriteData, DataAdr,
    output logic MemWrite
);
    logic [31:0] PC, Instr, ReadData;
    rv32i_sc rvsingle(.clk(clk), .rst_n(rst_n), .PC(PC), .instr(Instr), .MemWrite(MemWrite),
    .WriteData(WriteData), .ReadData(ReadData), .ALUResult(DataAdr));

    imem imem(.a(PC), .rd(Instr));

    dmem dmem(.clk(clk), .we(MemWrite) , .a(DataAdr), .wd(WriteData), .rd(ReadData));
 endmodule