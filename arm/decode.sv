module decode(input  logic			 Clk, Rst, RegWriteW,
				  input  logic [31:0] Instruction, ResultW, PCPlus8D,
				  input  logic [3:0]	 WA3W, flagsEin,
				  output logic [3:0]  WA3E, /*CondEPipeOutput,*/ flagsEout, ALUControlE,	
				  output logic [31:0] RD1, RD2, Extended,
				  output logic 		 ALUSrcE, MemToRegD, RegWriteD, PlusOne, BranchTakenE, PCSrcW);

				  
	//Instruction Mapping
	
	logic        Op;
	logic [3:0]  Funct;
	logic [3:0]  /*CondE,*/ decodeMux2x1ToRA1D_IN1, decodeMux2x1ToRA2D_IN1, decodeMux2x1ToRA2D_IN2;
	logic [23:0] ExtendedIN;
	
	//TODO ARREGLAR MAPEO
	assign Op 	 						= Instruction[25];
	assign Funct 						= Instruction[24:21];
	//assign CondE 						= Instruction[31:28];
	assign decodeMux2x1ToRA1D_IN1 = Instruction[19:16];
	assign decodeMux2x1ToRA2D_IN1 = Instruction[3:0];
	assign decodeMux2x1ToRA2D_IN2 = Instruction[15:12];
	assign ExtendedIN 				= Instruction[23:0];
	
	//Outputs
	
	logic [3:0]  decodeMux2x1ToRA1D_Output, decodeMux2x1ToRA2D_Output, decodeWA3E_Output, decodeALUControlE_Output, decodePipeALUControlE_Output, decodePipeFlagsE_Output;
	logic [31:0] decodeExtended_Output, decodeRD1_Output, decodeRD2_Output, decodePipeRA_Output, decodePipeRB_Output, decodePipeExtended_Output;
	logic [1:0]  decodeRegSrcD_Output, decodeInmRegSel_Output;
	logic			 decodeMemtoRegD_Output, decodeALUSrcE_Output, decodeRegWriteD_Output, decodePlusOne_Output, decodeBranchTake_Output, decodePCSrcW_Output, decodePipeRegWriteD_Output, decodePipePlusOne_Output, decodePipeBranchTake_Output, decodePipePCSrcW_Output, decodePipeALUSrcE_Output, decodePipeMemtoRegD_Output;
	
	//Components
	
	Control_unit
	controlUnit(Funct, Op, decodeALUSrcE_Output, decodeALUControlE_Output, decodeMemtoRegD_Output, decodeRegSrcD_Output, decodeInmRegSel_Output, decodeRegWriteD_Output, decodePlusOne_Output, decodeBranchTake_Output, decodePCSrcW_Output);
	
	mux2x1
	#(4)
	decodeMux2x1ToRA1D(decodeMux2x1ToRA1D_IN1, 15, decodeRegSrcD_Output[0], decodeMux2x1ToRA1D_Output);
	
	mux2x1
	#(4)
	decodeMux2x1ToRA2D(decodeMux2x1ToRA2D_IN1, decodeMux2x1ToRA2D_IN2, decodeRegSrcD_Output[1], decodeMux2x1ToRA2D_Output);
	
	extend
	extendUnit(ExtendedIN, decodeInmRegSel_Output, decodeExtended_Output);
	
	registerFile
	registerFileUnit(Clk, RegWriteW, decodeMux2x1ToRA1D_Output, decodeMux2x1ToRA2D_Output, WA3W, ResultW, PCPlus8D, decodeRD1_Output, decodeRD2_Output);

	pipeDecoExe
	pipeDE(Clk, Rst, decodeRD1_Output, decodeRD2_Output, decodeExtended_Output, decodePipeRA_Output, decodePipeRB_Output, decodePipeExtended_Output, decodeMux2x1ToRA2D_IN2, decodeWA3E_Output, decodeALUControlE_Output, decodePipeALUControlE_Output, flagsEin, decodePipeFlagsE_Output, decodeRegWriteD_Output, decodePlusOne_Output, decodeBranchTake_Output, decodePCSrcW_Output, decodeALUSrcE_Output, decodeMemtoRegD_Output, decodePipeRegWriteD_Output, decodePipePlusOne_Output, decodePipeBranchTake_Output, decodePipePCSrcW_Output, decodePipeALUSrcE_Output, decodePipeMemtoRegD_Output);
	
	//Set output signals
	
	assign WA3E  	 		  = decodeWA3E_Output;
	assign RD1  	 		  = decodePipeRA_Output;
	assign RD2 		 		  = decodePipeRB_Output;
	assign Extended 		  = decodePipeExtended_Output;
	assign flagsEout       = decodePipeFlagsE_Output;
	assign ALUSrcE         = decodePipeALUSrcE_Output;
	assign ALUControlE     = decodePipeALUControlE_Output;
	assign MemToRegD       = decodePipeMemtoRegD_Output;
	assign RegWriteD       = decodePipeRegWriteD_Output;
	assign PlusOne         = decodePipePlusOne_Output;
	assign BranchTakenE    = decodePipeBranchTake_Output;
	assign PCSrcW          = decodePipePCSrcW_Output;

endmodule 