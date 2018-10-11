`timescale 1ns / 1ns
`include "Control_params.vh"
module arm_tb;

logic clk, reset, write_enable, ImmEnable, SetFlags;
logic [31:0] PC, Instr, WriteAddress, WriteData, ReadData;
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
    .WriteAddress(WriteAddress), .WriteData(WriteData),
    .ReadData(ReadData)
);


//RAM
// ram	RAM1 (
// 	.address_a ( WriteAddress ),
// 	.clock_a ( clk ),
// 	.data_a ( WriteData ),
// 	.wren_a ( write_enable ),
// 	.q_a ( ReadData )
// 	);

initial 
begin

    //Initial state zero
    clk=1;
    N=0; Z=0; C=0; V=0;
    op = 0; cmd = 0;
	ImmEnable = 0; SetFlags = 0;
    rn = 0; rd = 0; rm = 0;
    src2 = 0;
    reset = 0; #2 reset = 1; #2 reset = 0;
    #4

    // ADD R0 , R0, #1
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 1; SetFlags = 1;
    rd = 0; rn = 0; src2 = {11'b0 , 1'b1};
    #2 // Un ciclo reloj

    //NOP
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj
   
    // ADD R1 , R0, #2
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 1; SetFlags = 1;
    rd = 1; rn = 0; src2 = {10'b0 , 2'b10};
    #2 // Un ciclo reloj

     //NOP
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj
    
    // ADD R2 , R1, #1
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 1; SetFlags = 1;
    rd = 2; rn = 1; src2 = {11'b0 , 1'b1};
    #2 // Un ciclo reloj

     //NOP
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj

    // ADD R3 , R2, #1
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 1; SetFlags = 1;
    rd = 3; rn = 2; src2 = {11'b0 , 1'b1};
    #2 // Un ciclo reloj

     //NOP
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj

    // ADD R4 , R3, #1
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 1; SetFlags = 1;
    rd = 4; rn = 3; src2 = {11'b0 , 1'b1};
    #2 // Un ciclo reloj

     //NOP
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj


    #8 $stop;


end

always   #1  clk =  ! clk; 

endmodule