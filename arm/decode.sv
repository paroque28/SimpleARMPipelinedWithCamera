module decode(input  logic			 Clk, Rst, RegSrcD, ImmSrcD, RegWriteW, PCSrcD, RegWriteD, MemToRegD, MemToWriteD, ALUControlD, BranchD, ALUSrcD, FlagWriteD, Flags, 
				  input  logic [31:0] Instruction, ResultW, PCPlus8D,
				  input  logic [3:0]	 WA3W,
				  output logic [3:0]  WA3E,
				  output logic [31:0] RD1, RD2, Extended,
				  output logic 		 PCSrcE, RegWriteE, MemToRegE, MemWriteE, ALUControlE, BranchE, ALUSrcE, FlagWriteE, CondEPipeOutput, FlagsE);

				  
	//Instruction Mapping
	
	logic [1:0]  Op;
	logic [5:0]  Funct;
	logic [3:0]  Rd, CondE, decodeMux2x1ToRA1D_IN1, decodeMux2x1ToRA2D_IN1, decodeMux2x1ToRA2D_IN2;
	logic [23:0] ExtendedIN;
	
	assign Op 	 						= Instruction[27:26];
	assign Funct 						= Instruction[25:20];
	assign Rd    						= Instruction[15:12];
	assign CondE 						= Instruction[31:28];
	assign decodeMux2x1ToRA1D_IN1 = Instruction[19:16];
	assign decodeMux2x1ToRA2D_IN1 = Instruction[3:0];
	assign decodeMux2x1ToRA2D_IN2 = Instruction[15:12];
	assign ExtendedIN 				= Instruction[23:0];
	
	//Outputs
	
	logic [3:0]  decodeMux2x1ToRA1D_Output, decodeMux2x1ToRA2D_Output, WA3E_Output;
	logic [31:0] decodeExtended_Output, decodeRD1_Output, decodeRD2_Output, decodePipeRA_Output, decodePipeRB_Output, decodePipeExtended_Output;

	//Components
	
	mux2x1
	#(4)
	decodeMux2x1ToRA1D(decodeMux2x1ToRA1D_IN1, 15, RegSrcD, decodeMux2x1ToRA1D_Output);
	
	mux2x1
	#(4)
	decodeMux2x1ToRA2D(decodeMux2x1ToRA2D_IN1, decodeMux2x1ToRA2D_IN2, RegSrcD, decodeMux2x1ToRA2D_Output);
	
	extend
	extendUnit(ExtendedIN, ImmSrcD, decodeExtended_Output);
	
	registerFile
	registerFileUnit(Clk, RegWriteW, decodeMux2x1ToRA1D_Output, decodeMux2x1ToRA2D_Output, WA3W, ResultW, PCPlus8D, decodeRD1_Output, decodeRD2_Output);

	pipeDecoExe
	pipeDE(Clk, Rst, decodeRD1_Output, decodePipeRA_Output, decodeRD2_Output, decodePipeRB_Output, decodeExtended_Output, decodePipeExtended_Output, decodeMux2x1ToRA2D_IN2, WA3E_Output);
	
	//Set output signals
	assign WA3E  	 = WA3E_Output;
	assign RD1  	 = decodePipeRA_Output;
	assign RD2 		 = decodePipeRB_Output;
	assign Extended = decodePipeExtended_Output;

endmodule 