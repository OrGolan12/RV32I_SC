module datapath_tb;
  logic clk;
  logic rst_n;
  logic [31:0] instr;
  logic RegWrite;
  logic [1:0] ImmSrc;
  logic ALUSrcB;
  logic [1:0] ResultSrc;
  logic PCSrc;
  logic [31:0] ReadData;
  logic [2:0] ALUControl;
  logic [31:0] PC;
  logic Zero;
  logic [31:0] ALUResult;
  logic [31:0] WriteData;

// DUT
datapath dut (
  .clk        (clk),
  .rst_n      (rst_n),
  .instr      (instr),
  .RegWrite   (RegWrite),
  .ImmSrc     (ImmSrc),
  .ALUSrcB     (ALUSrcB),
  .ResultSrc  (ResultSrc),
  .PCSrc      (PCSrc),
  .ReadData   (ReadData),
  .ALUControl (ALUControl),
  .PC         (PC),
  .Zero       (Zero),
  .ALUResult  (ALUResult),
  .WriteData  (WriteData)
);

initial clk = 0;
always #5 clk = ~clk;


function automatic [31:0] enc_addi(input int rd, input int rs1, input int imm12);
  // RISC-V ADDI: imm[11:0] | rs1 | funct3=000 | rd | opcode=0010011
  logic signed [11:0] imm_s = imm12;    // keep only 12 LSBs; treat as signed
  {RegWrite, ImmSrc, ALUSrcB, ResultSrc, ALUControl} = {1'b1, 2'b00, 1'b1, 2'b00, 3'b000};
  return {imm_s, rs1[4:0], 3'b000, rd[4:0], 7'b0010011};
endfunction


initial begin
  rst_n = 1;
  #5 rst_n = 0;
  #5 rst_n = 1;
  @(posedge clk);
  instr = enc_addi(5, 0, 3); // x5 = 0 + 3 = 3;
  #1;
  $display("r5 = %0d", dut.rf.rf[0]);
  @(posedge clk);
  instr = enc_addi(5, 5, 3);
  @(posedge clk);
  @(posedge clk);
  $finish();
end


// ---- VCD dump ----
initial begin
  $dumpfile("datapath_tb.vcd");
  $dumpvars(0, datapath_tb);
end
// ------------------
endmodule
