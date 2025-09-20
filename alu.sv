module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [2:0] ALUControl,
    output logic [31:0] y,
    output logic Zero
);

    always_comb begin
        case(ALUControl)
            000: //ADD
                y = a + b;
            001: //SUB
                y = a - b;
            101: //SLT
                y = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0;
            011: //OR
                y = a | b;
            010: //AND
                y = a & b;
            default:
                y = 32'bx;
        endcase
    end

    assign Zero = (y == 32'b0);

endmodule