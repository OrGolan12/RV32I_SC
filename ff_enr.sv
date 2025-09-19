module ff_enr(
    input clk,
    input rst_n,
    input en,
    input [31:0] d,
    output [31:0] q
);

    logic [31:0] q_reg;
    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            q_reg <= '0;
        else if(en)
            q_reg <= d;
    end

    assign q = q_reg;

endmodule
