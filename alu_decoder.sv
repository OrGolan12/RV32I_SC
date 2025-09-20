module alu_decoder(
    input [1:0] ALUOp,
    input [2:0] funct3,
    input op5,
    input funct7_5,
    output [2:0] ALUControl
);

    logic op5func7_5_concat = {op5, funct7_5};

    always_comb begin
        if(ALUOp == 2'b00)
            ALUControl = 3'b000;

        else if (ALUOp == 2'b01)
            ALUControl = 3'b001;

        else begin
            case(funct3)
                3'b000: begin
                            if(op5func7_5_concat == 00 || op5func7_5_concat == 01 || op5func7_5_concat == 10)
                                ALUControl = 3'b000;
                            else if (op5func7_5_concat == 11)
                                ALUControl = 3'b001;
                end
                3'b010:
                            ALUControl = 3'b101;
                3'b110:
                            ALUControl = 3'b011;
                3'b111:
                            ALUControl = 3'b010;
            endcase
        end

    end
endmodule
