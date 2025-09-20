module main_decoder(
    input [6:0] opcode,
    output RegWrite,
    output [1:0] ImmSrc,
    output ALUSrc,
    output MemWrite,
    output ResultSrc,
    output Branch,
    output [1:0] ALUOp
);

    always_comb begin
        case(opcode)
            7'b0000011:
                {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp} = {1'b1, 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 2'b00};
            7'b0100011:
                {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp} = {1'b0, 2'b01, 1'b1, 1'b1, 1'bx, 1'b0, 2'b00};                
            7'b0110011:
                {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp} = {1'b0, 2'b10, 1'b0, 1'b0, 1'bx, 1'b1, 2'b01};
            7'b1100011:
                {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp} = {1'b0, 2'b10, 1'b0, 1'b0, 1'bx, 1'b1, 2'b01};
            default:
                {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp} = {1'bx, 2'bxx, 1'bx, 1'bx, 1'bx, 1'bx, 2'bxx}; 
        endcase

    end

endmodule


