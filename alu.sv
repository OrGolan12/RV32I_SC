module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] ALUControl,
    output logic [31:0] y,
    output logic Zero,
    output logic NEG,
    output logic NEGU
);
    wire [31:0] b_eff   = b ^ {32{ALUControl[0]}};   // B or ~B
    wire        cin     = ALUControl[0];             // 0: ADD, 1: SUB

    // wide adders so we get carries
    wire [32:0] sum33   = {1'b0, a} + {1'b0, b_eff} + cin;     // full 32b add
    wire [31:0] sum     = sum33[31:0];
    wire        c_out   = sum33[32];

    // carry *into* MSB (from lower 31 bits)
    wire [31:0] low_sum32;
    wire        c_in31;
    assign {c_in31, low_sum32[30:0]} =
        {1'b0, a[30:0]} + {1'b0, b_eff[30:0]} + cin;

    // flags
    wire N = sum[31];
    wire V = c_in31 ^ c_out;     // signed overflow (add/sub)
    wire C = c_out;              // carry-out (for unsigned)

    assign NEG  = N ^ V;         // a < b (signed)  from a-b path
    assign NEGU = ~C;            // a < b (unsigned) : borrow = ~carry

    logic [4:0] shamt;
    assign shamt = b[4:0];

    always_comb begin
        case(ALUControl)
            4'b0000: //ADD
                y = sum;
            4'b0001: //SUB
                y = sum;
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

    assign Zero = (sum == 32'b0);

endmodule