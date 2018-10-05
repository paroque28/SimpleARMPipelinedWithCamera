module arm_tb;

logic clk, write_enable;
logic [31:0] PC, Instr, ALUResult, WriteData, ReadData;
logic op;
logic [3:0] funct, cond, rn, rd, rm;
logic [14:0] src2;
assign Instr = {cond, op, funct, rn, rd, src2};
arm  a1(
    .clk(clk),
    .reset(1'b0),
    .PC(PC),
    .Instruction(Instr),
    .write_enable(write_enable),
    .ALUResult(ALUResult), .WriteData(WriteData),
    .ReadData(ReadData)
);

//RAM

logic [15:0] address_a;
logic [31:0] q_a, data_a;
ram_2port	RAM_VIDEO (
	.address_a ( address_a ),
	.clock_a ( clk ),
	.data_a ( WriteData ),
	.wren_a ( write_enable ),
	.q_a ( ReadData )
	);


initial 
begin

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