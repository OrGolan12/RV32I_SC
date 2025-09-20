module alu_tb;
    logic [31:0] a;
    logic [31:0] b;
    logic [2:0] ALUControl;
    logic [31:0] y;

    alu dut(.a(a), .b(b), .ALUControl(ALUControl), .y(y));

    initial begin
        a = 32'd10;
        b = 32'd6;

        ALUControl = 3'b000;
        #1;
        assert (y == (a + b)) else $error("y != a + b when ALUControl: %b, a: %0d, b: %0d, y: %d", ALUControl, a, b, y);

        ALUControl = 3'b001;
        #1;
        assert (y == (a - b)) else $error("y != a - b when ALUControl: %b, a: %0d, b: %0d, y: %d", ALUControl, a, b, y);

        ALUControl = 3'b101;
        #1;
        assert (y == ($signed(a) <  $signed(b))) else $error("y != a < b when ALUControl: %b, a: %0d, b: %0d, y: %0d", ALUControl, a, b, y);

        ALUControl = 3'b011;
        #1;
        assert (y == (a | b)) else $error("y != a | b when ALUControl: %b, a: %0d, b: %0d, y: %0d", ALUControl, a, b, y);

        ALUControl = 3'b010;
        #1;
        assert (y == (a & b)) else $error("y != a & b when ALUControl: %b, a: %0d, b: %0d, y: %0d", ALUControl, a, b, y);


        $finish();
    end

    initial $monitor("At time %0t, a=%0d, b=%0d, y=%0d, ALUControl=%3b", $time, a, b, y, ALUControl);

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
    end

endmodule
