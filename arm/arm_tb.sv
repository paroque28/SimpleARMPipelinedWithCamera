`timescale 1ns / 1ns
`include "Control_params.vh"
module arm_tb;

logic clk, reset, write_enable, ImmEnable, SetFlags;
logic [31:0] PC, Instr, ALUResult, WriteData, ReadData;
logic [1:0] op;
logic [3:0] cmd, cond, rn, rd, rm;
logic [11:0] src2;
logic N,Z,C,V;
assign cond = {N,Z,C,V};
assign Instr = {cond, op, ImmEnable, cmd, SetFlags, rn, rd, src2};


arm  processor(
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .Instruction(Instr),
    .write_enable(write_enable),
    .ALUResult(ALUResult), .WriteData(WriteData),
    .ReadData(ReadData)
);

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

    //Initial state zero
    clk=1;
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
    reset = 0;
    #2
    reset = 1;
    #2
    reset = 0;
    
    // Add instruction
    #4
    op = OPDATA;
    cmd = FADD;
    ImmEnable = 1;
	SetFlags = 1;
    rn = 3;
    rd = 1;
    src2 = {11'b0 , 1'b1};
    
    //NOP
    #2
    op = 0;
    ImmEnable = 0;
    cmd = 4'b0000;
	SetFlags = 0;
    rn = 0;
    rd = 0;
    src2 = {11'b0 , 1'b0};
    
   
    // Sub instruction
    #8
    op = OPDATA;
    cmd = FSUB;
    ImmEnable = 1;
	SetFlags = 1;
    rn = 3;
    rd = 2;
    src2 = {11'b0 , 1'b1};


end

always   #1  clk =  ! clk; 

endmodule