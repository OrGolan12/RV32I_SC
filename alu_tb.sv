module alu_tb;
    logic [31:0] a;
    logic [31:0] b;
    logic [2:0] ALUControl;
    logic [31:0] y;

    alu dut(.a(a), .b(b), .ALUControl(ALUControl), .y(y));

    task automatic check_alu_seq(input logic [31:0] A, B);
        a = A;
        b = B;

        // ADD
        ALUControl = 3'b000; #1;
        assert (y == (a + b))
        else $error("ADD fail: a=%0d b=%0d y=%0d exp=%0d",
                    $signed(a), $signed(b), $signed(y), $signed(a+b));

        // SUB
        ALUControl = 3'b001; #1;
        assert (y == (a - b))
        else $error("SUB fail: a=%0d b=%0d y=%0d exp=%0d",
                    $signed(a), $signed(b), $signed(y), $signed(a-b));

        // SLT
        ALUControl = 3'b101; #1;
        assert (y == (($signed(a) < $signed(b)) ? 32'd1 : 32'd0))
        else $error("SLT fail: a=%0d b=%0d y=%0d exp=%0d",
                    $signed(a), $signed(b), $signed(y), ($signed(a) < $signed(b)));

        // OR
        ALUControl = 3'b011; #1;
        assert (y == (a | b))
        else $error("OR fail: a=%0d b=%0d y=%0d exp=%0d",
                    $signed(a), $signed(b), $signed(y), (a|b));

        // AND
        ALUControl = 3'b010; #1;
        assert (y == (a & b))
        else $error("AND fail: a=%0d b=%0d y=%0d exp=%0d",
                    $signed(a), $signed(b), $signed(y), (a&b));
    endtask

    initial begin
        //check_alu_seq(32'd10, 32'd6);      // run sequence with (10,6)
        check_alu_seq(-5, 32'd3);     // run sequence with (-5,3)
        $display("All ALU sequences done.");
        $finish;
    end

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
    end

endmodule
