module imem(
    input logic [31:0] a,
    output logic [31:0] rd
);
    logic [31:0] mem [63:0];
    initial
       $readmemh("test1.txt",mem);
    assign rd = mem[a[31:2]]; // word aligned
 endmodule
