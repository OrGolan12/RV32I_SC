module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [2:0] ALUControl,
    output logic [31:0] y,
    output logic Zero
);

    always_comb begin
        case(ALUControl)
            3'b000: //ADD
                y = a + b;
            3'b001: //SUB
                y = a - b;
            3'b101: //SLT
                y = (a < b) ? 32'b1 : 32'b0;
            3'b011: //OR
                y = a | b;
            3'b010: //AND
                y = a & b;
            default:
                y = 32'bx;
        endcase
    end

    assign Zero = (y == 32'b0);

endmodule