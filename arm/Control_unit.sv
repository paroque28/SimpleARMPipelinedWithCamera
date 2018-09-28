module Control_unit (input logic [3:0] opcode,
							input logic funct,
							output logic ALUSrcE,
							output logic [3:0]ALUControlE,
							output logic TfuWD,
							output logic TFUAdd,
							output logic [1:0] MemRd,
							output logic [1:0] MemtoRegW,
							output logic [1:0] RegSrcD,
							output logic ImmSrcD,
							output logic RegWriteD,
							);
							
always_comb
begin

	case(opcode)
	
	4'b0000: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	2'b00;
			ImmSrcD 		=	;
			RegWriteD   =	1;
	4'b0001: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b0010: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b0011: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b0100: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b0101: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b0110: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b0111: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1000: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1001: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1010: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1011: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1100: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1101: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1110: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;
	4'b1111: 
			ALUSrcE 		=	;
			ALUControlE =	;
			TfuWD 		=	;
			TFUAdd 		=	;
			MemRd 		=	;
			MemtoRegW 	=	;
			RegSrcD 		=	;
			ImmSrcD 		=	;
			RegWriteD   =	;	

end

endmodule
