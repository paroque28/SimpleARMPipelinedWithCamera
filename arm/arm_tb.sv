`timescale 1ns / 1ps
`include "Control_params.vh"
module arm_tb;

logic clk, reset, write_enable, ImmEnable, SetFlags;
logic [31:0] PC, Instr, WriteAddress, WriteData, ReadData;
logic [1:0] op;
logic [3:0] cmd, cond, rn, rd, rm;
logic [11:0] src2;
logic N,Z,C,V;
assign cond = {N,Z,C,V};
// Functions data operations
assign Instr = {cond, op, ImmEnable, cmd, SetFlags, rn, rd, src2};
// Functions of memory operations


arm  processor(
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .Instruction(Instr),
    .write_enable(write_enable),
    .WriteAddress(WriteAddress), .WriteData(WriteData),
    .ReadData(ReadData)
);

//
//ram	RAM1 (
//	.address_a ( WriteAddress ),
//	.clock_a ( clk ),
//	.data_a ( WriteData ),
//	.wren_a ( write_enable ),
//	.q_a ( ReadData )
//	);
assign ReadData = 32'b0; //comment when RAM enabled

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
 
    // ADD R1 , R1, #255
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 1; SetFlags = 1;
    rd = 1; rn = 1; src2 = {12'hFFF};
    #2 // Un ciclo reloj

    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj

    // ADD R2 , R2, #0
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 1; SetFlags = 1;
    rd = 2; rn = 2; src2 = {12'hFFF};
    #2 // Un ciclo reloj
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj

    // MULT R8 , R8, #12'b1000
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FSR;
    ImmEnable = 1; SetFlags = 1;
    rd = 7; rn = 1; src2 = {12'b1000};
    #2 // Un ciclo reloj

    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj

    // MULT R8 , R2, #0
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FSR;
    ImmEnable = 1; SetFlags = 1;
    rd = 8  ; rn = 2; src2 = {12'b1000000};
    #2 // Un ciclo reloj

    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj

    // ADD R9 , R8, R7
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FADD;
    ImmEnable = 0; SetFlags = 1;
    rd = 9; rn = 8; rm = 7;
    #2 // Un ciclo reloj
   
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8  // Cuatro ciclos reloj

    // AVERAGE 
    N=1; Z=1; C=1; V=0;
    op = OPDATA;cmd = FAVERAGE;
    ImmEnable = 0; SetFlags = 1;
    rd = 8; rn = 8; src2 = {12'b101 };
    #2 // Un ciclo reloj
    //NOP
    N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    #8;  // Cuatro ciclos reloj

    // // STR R4 , R3, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPMEMORY;cmd = 0; // Zero to work with memeory DOWN and not plusOne
    // ImmEnable = 1; SetFlags = 0;
    // rd = 0; rn = 3; src2 = {12'b0 }; //Rd = source, rn = reference, src offset
    // #2 // Un ciclo reloj

    // ldr r3, r1, r2
    // avg r4, r3
    // str r4, r1, r2

    // // ADD R0 , R0, #7
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FADD;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 0; rn = 0; src2 = {12'b111};
    // #2 // Un ciclo reloj

    // //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj
    
    // // STR R4 , R3, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPMEMORY;cmd = 0; // Zero to work with memeory DOWN and not plusOne
    // ImmEnable = 1; SetFlags = 0;
    // rd = 0; rn = 3; src2 = {12'b0 };
    // #2 // Un ciclo reloj

    // //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj
    
    // // LDR R4 , R3, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPMEMORY;cmd = 0; // Zero to work with memeory DOWN and not plusOne
    // ImmEnable = 1; SetFlags = 1;
    // rd = 7; rn = 3; src2 = {12'b0 };
    // #2 // Un ciclo reloj

    // //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj

    // // ADD R1 , R0, #2
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FADD;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 1; rn = 7; src2 = {10'b0 , 2'b10};
    // #2 // Un ciclo reloj

    //  //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj
    
    // // ADD R2 , R1, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FADD;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 2; rn = 1; src2 = {11'b0 , 1'b1};
    // #2 // Un ciclo reloj

    //  //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj

    // // ADD R3 , R2, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FADD;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 3; rn = 2; src2 = {11'b0 , 1'b1};
    // #2 // Un ciclo reloj

    //  //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj

    // // ADD R4 , R3, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FADD;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 4; rn = 3; src2 = {11'b0 , 1'b1};
    // #2 // Un ciclo reloj

    //  //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj

    // // SUB R8 , R3, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FSUB;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 4; rn = 3; src2 = {11'b0 , 1'b1};
    // #2 // Un ciclo reloj
    //  //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj

    // // B #4
    // N=1; Z=1; C=1; V=0;
    // op = OPBRANCH; cmd = 0;
    // ImmEnable = 1; SetFlags = 0;
    // rd = 0; rn = 0; src2 = 16;
    // #2 // Un ciclo reloj

    //  //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj
    
    // // ADD R4 , R3, #1
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FADD;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 13; rn = 1; src2 = {12'b101 };
    // #2 // Un ciclo reloj
    // //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj

    // //
    // N=1; Z=1; C=1; V=0;
    // op = OPDATA;cmd = FAVERAGE;
    // ImmEnable = 1; SetFlags = 1;
    // rd = 13; rn = 13; src2 = {11'b0 , 1'b1};
    // #2 // Un ciclo reloj
  
    //  //NOP
    // N=0; Z=0; C=0; V=0; op = 0;ImmEnable = 0;cmd = 4'b0000;SetFlags = 0;rn = 0; rd = 0;src2 = 12'b0;
    // #8  // Cuatro ciclos reloj
    #8 $stop;
	 end


always   #1  clk =  ! clk; 

endmodule