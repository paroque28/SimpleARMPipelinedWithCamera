
module Control_unit (input logic [3:0] funct,
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
							output logic MemSelE,
							output logic BranchTakenE,
							output logic PCSrcW
							);


`include "ALU_params.h"
	

	
always_comb
begin

	case(funct)
	
	4'b0000: //Case SUM
	begin
			ALUSrcE 		=	opcode;
			ALUControlE =	ADD;
			//TfuWD 		=	;
			//TFUAdd 	=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	4'b0001: //Case SUBS
	begin
			ALUSrcE 		=	opcode;
			ALUControlE =	SUB;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	4'b0010: //Case MULT
	begin
			ALUSrcE 		=	opcode;
			ALUControlE =	MULT;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
	end	
			
	4'b0100: //Case LOAD
	begin
			ALUSrcE 		=	opcode;
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	0;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  1;
	end		
	4'b0101: //Case Store
	begin
			ALUSrcE 		=	opcode; //Revisar si no hace falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	0;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b0;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  opcode;
			MemSelE		=  1;
	end		
	/*		
	4'b0110: //Case Shift Left
	begin
			ALUSrcE 		=	;
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	4'b0111: //Case Shift Right
	begin
			ALUSrcE 		=	;
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	4'b1000: //Case Branch
	begin
			ALUSrcE 		=	;
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	4'b1001: //Case Take Picture
	begin
			ALUSrcE 		=	;
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
			end*/
			
	4'b1010: //Case Ponderate RGB
	begin
			ALUSrcE 		=	opcode;
			ALUControlE =	4'b0111;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	2'b00;
			MemtoRegW 	=	2'b01;
			RegSrcD 		=	2'b00;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  0;
	end		
	4'b1011: //Case Load Aligned
	begin
			ALUSrcE 		=	opcode;
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	2'b10;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b1;
			RdD         =  Rd;
			PlusOne		=  0;
			InmRegSel   =  0;
			MemSelE		=  1;
	end		
	4'b1100: //Case Store Plus One
	begin
			ALUSrcE 		=	opcode; //Revisar si no hace falta un MUX para pasar Reg2 o Inmediato a ser escrito
			ALUControlE =	4'b0000;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	0; //Check if this is not decided by the memory selector
			MemtoRegW 	=	0;
			RegSrcD 		=	0;
			//ImmSrcD 		=	;
			RegWriteD   =	1'b0;
			RdD         =  Rd;
			PlusOne		=  1;
			InmRegSel   =  opcode;
			MemSelE		=  1;
	end		
		/*	
	4'b1101: //Case Thinning
	begin
			ALUSrcE 		=	;
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  Rd;
			PlusOne		=  1;
			InmRegSel   =  opcode;
			MemSelE		=  0;
	end		
	4'b1110: 
	begin
			ALUSrcE 		=	;
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;
			RdD         =  ;
			PlusOne		=  ;
			InmRegSel   =  ;
			MemSelE		=  ;
	end		
	4'b1111: 
	begin
			ALUSrcE 		=	;
			ALUControlE =	;
			//TfuWD 		=	;
			//TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			//ImmSrcD 		=	;
			RegWriteD   =	;	
			RdD         =  ;
			PlusOne		=  ;
			InmRegSel   =  ;
			MemSelE		=  ;
			end*/
	default: 
	begin
			ALUSrcE 		=	1'bz;
			ALUControlE =	1'bz;
			//TfuWD 		=	x;
			//TFUAdd 		=	x;
			MemRd 		=	1'bz;
			MemtoRegW 	=	1'bz;
			RegSrcD 		=	1'bz;
			//ImmSrcD 		=	x;
			RegWriteD   =	1'bz;	
			RdD         =  1'bz;
			PlusOne		=  1'bz;
			InmRegSel   =  1'bz;
			MemSelE		=  1'bz;
			end
	endcase
end


endmodule
