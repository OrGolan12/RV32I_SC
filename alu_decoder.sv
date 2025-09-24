module alu_decoder(
    input logic [1:0] ALUOp,
    input logic [2:0] funct3,
    input logic op5,
    input logic funct7_5,
    output logic [2:0] ALUControl
);

    logic [1:0] op5func7_5_concat;
    assign op5func7_5_concat = {op5, funct7_5};

    always_comb begin
        if(ALUOp == 2'b00)
            ALUControl = 3'b000;

        else if (ALUOp == 2'b01)
            ALUControl = 3'b001;

        else begin
            case(funct3)
                3'b000: begin
                            if(op5func7_5_concat == 2'b00 || op5func7_5_concat == 2'b01 || op5func7_5_concat == 2'b10)
                                ALUControl = 3'b000;
                            else if (op5func7_5_concat == 2'b11)
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
