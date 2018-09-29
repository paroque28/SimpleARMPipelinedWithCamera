
module Control_unit (input logic CLK,
							input logic [3:0] funct,
							input logic opcode,
							input logic [4:0] Rd,
							output logic ALUSrcE,
							output logic [3:0] ALUControlE,
							//output logic TfuWD,
							//output logic TFUAdd,
							output logic [1:0] MemRd,
							output logic [1:0] MemtoRegW,
							output logic [1:0] RegSrcD,
							//output logic ImmSrcD,
							output logic RegWriteD,
							output logic [4:0] RdD,
							output logic PlusOne,
							output logic InmRegSel,
							output logic MemSelE
							);


`include "ALU_params.h"
`include "Control_params.h"	

assign PlusOne = (funct == 4'b1100);
assign ALUSrcE = opcode;

always_comb
begin

	case(funct)
	
	fADD: //Case ADD
	begin
			ALUControlE =	ADD;
			//TfuWD 		=	;
			//TFUAdd 	=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	fSUB: //Case SUBS
	begin
			ALUControlE =	SUB;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	fMULT: //Case MULT
	begin
			ALUControlE =	MULT;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
	end	
			
	fLOAD: //Case LOAD
	begin
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	0;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  1;
	end		
	fSTR: //Case Store
	begin //Revisar si no hace falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	0;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b0;
			RdD         =  Rd;
			InmRegSel   =  opcode;
			MemSelE		=  1;
	end		
	/*		
	fSL: //Case Shift Left
	begin
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	fSR: //Case Shift Right
	begin
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	fB: //Case Branch
	begin
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	fPIC: //Case Take Picture
	begin
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
			end*/
			
	fAVERAGE: //Case Ponderate RGB
	begin
			ALUControlE =	4'b0111;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	fLDA: //Case Load Aligned
	begin
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	2'b10;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			InmRegSel   =  0;
			MemSelE		=  1;
	end		
	fSTR_ONE: //Case Store Plus One
	begin //Revisar si no hace falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	0;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b0;
			RdD         =  Rd;
			InmRegSel   =  opcode;
			MemSelE		=  1;
	end		
			
	// fTHI: //Case Thinning
	// begin
	/
	// 		ALUControlE =	;
	// 		//TfuWD 		=	;
	// 		//TFUAdd 		=	;
	// 		MemRd 		=	;
	// 		MemtoRegW 	=	;
	// 		RegSrcD 		=	;
	// 		//ImmSrcD 		=	;
	// 		RegWriteD   =	;
	// 		RdD         =  Rd;
	// 		InmRegSel   =  opcode;
	// 		MemSelE		=  0;
	// end		
	// 4'b1110: 
	// begin
	/
	// 		ALUControlE =	;
	// 		//TfuWD 		=	;
	// 		//TFUAdd 		=	;
	// 		MemRd 		=	;
	// 		MemtoRegW 	=	;
	// 		RegSrcD 		=	;
	// 		//ImmSrcD 		=	;
	// 		RegWriteD   =	;
	// 		RdD         =  ;
	// 		InmRegSel   =  ;
	// 		MemSelE		=  ;
	// end		
	// 4'b1111: 
	// begin
	/
	// 		ALUControlE =	;
	// 		//TfuWD 		=	;
	// 		//TFUAdd 		=	;
	// 		MemRd 		=	;
	// 		MemtoRegW 	=	;
	// 		RegSrcD 		=	;
	// 		//ImmSrcD 		=	;
	// 		RegWriteD   =	;	
	// 		RdD         =  ;
	// 		InmRegSel   =  ;
	// 		MemSelE		=  ;
	// 		end
	default: 
	begin
			ALUControlE =	1'bz;
			//TfuWD 		=	x;
			//TFUAdd 		=	x;
			MemRd 		=	1'bz;
			MemtoRegW 	=	1'bz;
			RegSrcD 		=	1'bz;
			//ImmSrcD 		=	x;
			RegWriteD   =	1'bz;	
			RdD         =  1'bz;
			InmRegSel   =  1'bz;
			MemSelE		=  1'bz;
			end
	endcase
end


endmodule
