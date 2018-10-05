`timescale 1ns / 1ns
module arm_tb;

logic clk, write_enable, ImmEnable, SetFlags;
logic [31:0] PC, Instr, ALUResult, WriteData, ReadData;
logic [1:0] op;
logic [3:0] cmd, cond, rn, rd, rm;
logic [11:0] src2;
logic N,Z,C,V;
assign cond = {N,Z,C,V};
assign Instr = {cond, op, ImmEnable, cmd, SetFlags, rn, rd, src2};


//RAM
ram	RAM1 (
	.address_a ( ALUResult ),
	.clock_a ( clk ),
	.data_a ( WriteData ),
	.wren_a ( write_enable ),
	.q_a ( ReadData )
	);


initial 
begin

    N=0;
    Z=0;
    C=0;
    V=0;
    op = 0;
	ImmEnable = 0;
    cmd = 0;
	SetFlags = 0;
    rn = 0;
    rd = 0;
    rm = 0;
    src2 = 0;

    #4
    N=0;
    Z=0;
    C=0;
    V=0;
    op = 1;
    ImmEnable = 1;
    cmd = 0;
	SetFlags = 0;
    rn = 3;
    rd = 1;
    rm = 2;
    src2 = {11'b0 , 1'b1};


end

always   #1  clk =  ! clk; 

endmodule