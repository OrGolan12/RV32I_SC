module imm_extend (
    input [31:7] in,
    input [1:0] ImmSrc,
    output [31:0] immExt
);

    always_comb begin
        case(ImmSrc)
            2'b00: //I-TYPE
                immExt = {{20{in[31]}}, in[31:20]};
            2'b01: //S-TYPE
                immExt = {{20{in[31]}}, in[31:25], in[11:7]};
            2'b10: //B-TYPE
                immExt = {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0};
            2'b11: //J-TYPE
                immExt = {{20{in[31]}}, in[19:12], in[20], in[30:21], 1'b0};
            default:
                immExt = 32'bx;
        endcase
    end

endmodule
