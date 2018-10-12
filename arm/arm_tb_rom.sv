`timescale 1ns / 1ps
module arm_tb_rom;

logic clk, reset, write_enable, ImmEnable, SetFlags;
logic [31:0] PC, Instr, WriteAddress, WriteData, ReadData;
logic [1:0] op;
logic [3:0] cmd, cond, rn, rd, rm;
logic [11:0] src2;
logic N,Z,C,V;
// Visualization variables
assign {N,Z,C,V} = cond;
assign {cond, op, ImmEnable, cmd, SetFlags, rn, rd, src2} = Instr;
assign rm = Instr[3:0];
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

mem_controller mem (    .clk(clk),
                        .address(WriteAddress), .data_in(WriteData),
                        .we(write_enable),
                        .data_out(ReadData));

insMem ROM (
    .a(PC),
    .d(Instr)
);

initial 
begin

    //Initial state zero
    clk=1;
    reset = 1; #2 reset = 0;
    #100
    
  

    #8 $stop;


end

always   #1  clk =  ! clk; 

endmodule