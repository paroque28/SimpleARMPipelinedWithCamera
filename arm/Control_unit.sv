
module Control_unit (input logic [5:0] funct,
							input logic [1:0]opcode,
							output logic ALUSrcE,
							output logic [3:0] ALUControlE,
							output logic MemToRegD,
							output logic [1:0] RegSrcD, // No va al pipe
							output logic [1:0]ImmSrcD, // No va al pipe
							output logic RegWriteD,
							output logic PlusOne,
							output logic BranchD,
							output logic PCSrcW
							);


`include "ALU_params.vh"
`include "Control_params.vh"

logic [3:0] cmd;
logic ALUOp;

assign cmd = funct [4:1];
assign PlusOne = (cmd == FSTR_ONE);
assign ALUSrcE = opcode[0];
assign MemToRegD = (cmd == FLOAD);
assign RegWriteD = ~(cmd == FSTR || cmd == FPIC || cmd == FNOP);
assign ImmSrcD[0] = (cmd == FSTR || cmd == FLOAD); //LUT
assign ImmSrcD[1] = (cmd == FB); //LUT

assign BranchD = (opcode == OPBRANCH);
assign ALUOp = (opcode == OPDATA);
assign RegSrcD[0] = (opcode == OPBRANCH);
assign RegSrcD[1] = (opcode == OPMEMORY && ~funct[0]);

always_comb
begin

	case(cmd)
	FNOP: begin //Case AND
			ALUControlE =	NOP;
	end
	FADD: begin //Case ADD
			ALUControlE =	ADD;
	end
	FSUB: begin //Case SUBS
			ALUControlE =	SUB;
	end
	FMULT: begin //Case MULT
			ALUControlE =	MULT;
	end
	FLOAD: begin//Case LOAD
			ALUControlE =	BUFFER;
	end
	FSTR: begin//Case Store
	 //Revisar si no hace Falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	BUFFER;
	end
	FAVERAGE: begin//Case Ponderate RGB
			ALUControlE =	AV;
	end
	FSTR_ONE: begin//Case Store Plus One //Revisar si no hace Falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	BUFFER;
	end
	default:
	begin
			ALUControlE =	4'bz;
			end
	endcase
end


endmodule
