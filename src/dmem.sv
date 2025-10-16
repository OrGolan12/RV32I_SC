module dmem(
    input  logic        clk, we,
    input  logic [31:0] a, wd,
    input  logic [2:0]  MemSize,   // 000=SB, 001=SH, 010=SW
    output logic [31:0] rd
);
    logic [31:0] mem [0:63];

    always_ff @(posedge clk) begin
        if (we) begin
            case (MemSize)
                3'b010: begin // SW
                    mem[a[31:2]] <= wd;
                end
                3'b001: begin // SH
                    case (a[1])
                        1'b0: mem[a[31:2]][15:0]  <= wd[15:0];
                        1'b1: mem[a[31:2]][31:16] <= wd[15:0];
                    endcase
                end
                3'b000: begin // SB
                    case (a[1:0])
                        2'b00: mem[a[31:2]][7:0]   <= wd[7:0];
                        2'b01: mem[a[31:2]][15:8]  <= wd[7:0];
                        2'b10: mem[a[31:2]][23:16] <= wd[7:0];
                        2'b11: mem[a[31:2]][31:24] <= wd[7:0];
                    endcase
                end
            endcase
        end
    end

    assign rd = mem[a[31:2]]; // word-aligned read

endmodule
