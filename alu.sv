module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] ALUControl,
    output logic [31:0] y,
    output logic Zero
);

    logic [4:0] shamt;
    assign shamt = b[4:0];

    always_comb begin
        case(ALUControl)
            4'b0000: //ADD
                y = a + b;
            4'b0001: //SUB
                y = a - b;
            4'b0101: //SLT
                y = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0;
            4'b0011: //OR
                y = a | b;
            4'b0010: //AND
                y = a & b;
            4'b0100:
                y = a ^ b;
            4'b0110:
                y = a << shamt;
            4'b0111:
                y = $unsigned(a) >> shamt;
            4'b1000:
                y = $signed(a) >>> shamt;
            default:
                y = 32'bx;
        endcase
    end

    assign Zero = (y == 32'b0);

endmodule