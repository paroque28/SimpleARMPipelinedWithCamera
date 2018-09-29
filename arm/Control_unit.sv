
module Control_unit (input logic [3:0] funct,
							input logic opcode,
							output logic ALUSrcE,
							output logic [3:0] ALUControlE,
							output logic MemToRegD,
							output logic [1:0] RegSrcD,
							output logic [1:0]ImmSrcD,
							output logic RegWriteD,
							output logic PlusOne,
							output logic BranchTakenE,
							output logic PCSrcW
							);
 

`include "ALU_params.h"
`include "Control_params.h"	

assign PlusOne = (funct == fSTR_ONE);
assign ALUSrcE = opcode;
assign MemToRegD = (funct == fLOAD);
assign RegWriteD = ~(funct == fSTR || funct == fPIC);

assign ImmSrcD[0] = (funct == fSTR || funct == fLOAD); //LUT
assign ImmSrcD[1] = (funct == fB); //LUT


always_comb
begin

	case(funct)
	fADD: begin //Case ADD
			ALUControlE =	ADD;
			RegSrcD 		=	2'b00;
	end		
	fSUB: begin //Case SUBS
			ALUControlE =	SUB;
			RegSrcD 		=	2'b00;
	end		
	fMULT: begin //Case MULT
			ALUControlE =	MULT;
			RegSrcD 		=	2'b00;
	end	
			
	fLOAD: begin//Case LOAD
			ALUControlE =	BUFFER;
			RegSrcD 		=	0;
	end		
	fSTR: begin//Case Store
	 //Revisar si no hace falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	BUFFER;
			RegSrcD 		=	0;
	end		
	/*		
	fSL: begin //Case Shift Left
			ALUControlE =	;
			RegSrcD 		=	;
	end		
	fSR: begin//Case Shift Right
			ALUControlE =	;
			RegSrcD 		=	;
	end		
	fB: begin//Case Branch
			ALUControlE =	;
			RegSrcD 		=	;
	end		
	fPIC: begin//Case Take Picture
			ALUControlE =	;
			RegSrcD 		=	;
			end*/
			
	fAVERAGE: begin//Case Ponderate RGB
			ALUControlE =	AV;
			RegSrcD 		=	2'b00;
	end		
	fSTR_ONE: begin//Case Store Plus One //Revisar si no hace falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	BUFFER;
			RegSrcD 		=	0;
	end		
	// fTHI: begin//Case Thinning
	// 		ALUControlE =	;
	// 		RegSrcD 		=	;
	// end		
	// 4'b1110: begin
	// 		ALUControlE =	;
	// 		RegSrcD 		=	;
	// 		//ImmSrcD 		=	
	// end		
	// 4'b1111: begin
	// 		ALUControlE =	;
	// 		RegSrcD 		=	;
	// 		end
	default: 
	begin
			ALUControlE =	1'bz;
			RegSrcD 		=	1'bz;
			end
	endcase
end


endmodule
