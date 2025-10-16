module regfile_tb;
    logic clk;
    logic RegWrite;
    logic [4:0] a1, a2, a3;
    logic [31:0] wd3;
    logic [31:0] rd1;
    logic [31:0] rd2;

    regfile dut(clk, RegWrite, a1, a2, a3, wd3, rd1, rd2);

    initial clk = 0;
    always #5 clk = ~ clk;

    initial begin
        @(posedge clk);
        a3 = 5;
        wd3 = 3;
        RegWrite = 1;
        @(posedge clk);
        $display("rf[%d] should be %d, and its %d", a3, wd3, dut.rf[a3]);
        #5;
        $finish();





    end

    // ---- VCD dump ----
    initial begin
    $dumpfile("regfile_tb.vcd");
    $dumpvars(0, regfile_tb);
    end
    // ------------------





endmodule
