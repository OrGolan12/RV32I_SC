module rv32i_sc_tb();
    logic        clk;
    logic        reset;
    logic [31:0] WriteData, DataAdr;
    logic        MemWrite;

    // instantiate device to be tested
    top dut(.clk(clk), .rst_n(reset), .WriteData(WriteData), .DataAdr(DataAdr), .MemWrite(MemWrite));

    // initialize test
    initial begin
        reset <= 0;
        #22;
        reset <= 1;
    end

initial $monitor("[%0t] a1=0x%08x, rs1=0x%08x, a2=0x%08x, rs2=0x%08x, a3=0x%08x, rd=0x%08x", $time, dut.rvsingle.dp.rf.a1,
    dut.rvsingle.dp.rf.rd1, dut.rvsingle.dp.rf.a2, dut.rvsingle.dp.rf.rd2, dut.rvsingle.dp.rf.a3, dut.rvsingle.dp.rf.wd3);

    always begin
        clk <= 1;
        #5;
        clk <= 0;
        #5;
    end

    initial begin
    #10000;   // run for 10,000 time units
    $display("Simulation finished by timeout");
    $writememh("rf_dump.hex", dut.rvsingle.dp.rf.rf);
    $writememh("d_mem.hex", dut.dmem.mem);
    $finish;
    end

    // check results
    always @(negedge clk) begin
        if (MemWrite) begin
            if ((DataAdr === 100) && (WriteData === 25)) begin
                $display("Simulation succeeded");
                //$stop;
            end
            else if (DataAdr !== 96) begin
                $display("Simulation failed");
                //$stop;
            end
        end
    end

    // ---- VCD dump ----
    initial begin
        $dumpfile("rv32i_sc_tb.vcd");
        $dumpvars(0, rv32i_sc_tb);
        $dumpvars(0, rv32i_sc_tb.dut.rvsingle.dp.rf);
    end
    // ------------------

endmodule
