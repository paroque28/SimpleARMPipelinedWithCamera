
module Control_unit (input logic [5:0] funct,
							input logic [1:0]opcode,
							output logic ALUSrcE,
							output logic [3:0] ALUControlE,
							output logic MemToRegD,
							output logic [1:0] RegSrcD, // No va al pipe
							output logic [1:0]ImmSrcD, // No va al pipe
							output logic RegWriteD,
							output logic PlusOne,
							output logic BranchTakenE,
							output logic PCSrcW
							);


`include "ALU_params.vh"
`include "Control_params.vh"

logic [3:0] cmd;
logic Branch, ALUOp;

assign cmd = funct [4:1];
assign PlusOne = (cmd == FSTR_ONE);
assign ALUSrcE = opcode[0];
assign MemToRegD = (cmd == FLOAD);
assign RegWriteD = ~(cmd == FSTR || cmd == FPIC);

assign ImmSrcD[0] = (cmd == FSTR || cmd == FLOAD); //LUT
assign ImmSrcD[1] = (cmd == FB); //LUT
assign Branch = (opcode == OPBRANCH);
assign ALUOp = (opcode == OPDATA);

always_comb
begin

	case(cmd)
	FADD: begin //Case ADD
			ALUControlE =	ADD;
			RegSrcD 		=	2'b00;
	end
	FSUB: begin //Case SUBS
			ALUControlE =	SUB;
			RegSrcD 		=	2'b00;
	end
	FMULT: begin //Case MULT
			ALUControlE =	MULT;
			RegSrcD 		=	2'b00;
	end
	FLOAD: begin//Case LOAD
			ALUControlE =	BUFFER;
			RegSrcD 		=	0;
	end
	FSTR: begin//Case Store
	 //Revisar si no hace Falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	BUFFER;
			RegSrcD 		=	0;
	end
	FAVERAGE: begin//Case Ponderate RGB
			ALUControlE =	AV;
			RegSrcD 		=	2'b00;
	end
	FSTR_ONE: begin//Case Store Plus One //Revisar si no hace Falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	BUFFER;
			RegSrcD 		=	0;
	end
	default:
	begin
			ALUControlE =	1'bz;
			RegSrcD 		=	1'bz;
			end
	endcase
end


endmodule
