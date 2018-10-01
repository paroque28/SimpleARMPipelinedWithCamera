module arm_tb;

logic clk, MemWrite;
logic [31:0] PC, Instr, ALUResult, WriteData, ReadData;
logic op;
logic [3:0] funct, cond, rn, rd, rm;
logic [14:0] src2;
assign Instr = {cond, op, funct, rn, rd, src2};
arm  a1(
    .clk(clk),
    .PC(PC),
    .Instr(Instr),
    .MemWrite(MemWrite),
    .ALUResult(ALUResult), .WriteData(WriteData),
    .ReadData(ReadData)
);

initial 
begin
    ReadData = 0;

    op = 0;
    funct = 0;
    cond = 0;
    rn = 0;
    rd = 0;
    rm = 0;
    src2 = 0;
    

    #4
    op = 1;
    funct = 1;
    cond = 0;
    rn = 3;
    rd = 1;
    rm = 2;
    src2 = {11'b0 , rm};


end

always   #1  clk =  ! clk; 

endmodule