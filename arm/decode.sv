module decode(input  logic			 clk, reset, RegWriteW,
				  input  logic [31:0] Instruction, ResultW, PCPlus8D,
				  input  logic [3:0]	 WA3W, flagsEin,
				  output logic [3:0]  WA3E, CondEPipeOutput, flagsEout, ALUControlE,
				  output logic [31:0] RD1, RD2, RD3, Extended,
				  output logic 		 ALUSrcE, MemToRegD, RegWriteD, PlusOne, BranchTakenE, PCSrcW);


	//Instruction Mapping

	logic [1:0]     Op;
	logic [5:0]  Funct;
	logic [3:0]  CondE, decodeMux2x1ToRA1D_IN1, decodeMux2x1ToRA2D_IN1, decodeMux2x1ToRA2D_IN2;
	logic [23:0] ExtendedIN;

	//TODO ARREGLAR MAPEO
	assign Op 	 						= Instruction[27:26];
	assign Funct 						= Instruction[25:20];
	assign CondE 						= Instruction[31:28];
	assign decodeMux2x1ToRA1D_IN1 = Instruction[19:16];
	assign decodeMux2x1ToRA2D_IN1 = Instruction[3:0];
	assign decodeMux2x1ToRA2D_IN2 = Instruction[15:12];
	assign ExtendedIN 				= Instruction[23:0];

	//Outputs

	logic [3:0]  decodeMux2x1ToRA1D_Output, decodeMux2x1ToRA2D_Output, decodeMux2x1ToRA3D_Output, decodeWA3E_Output,
	             decodeALUControlE_Output, decodePipeALUControlE_Output,
					 decodePipeFlagsE_Output, decodePipeCondE_Output;

	logic [31:0] decodeExtended_Output, decodeRD1_Output, decodeRD2_Output,decodeRD3_Output, decodePipeRA_Output,
	             decodePipeRB_Output, decodePipeRC_Output, decodePipeExtended_Output;

	logic [1:0]  decodeRegSrcD_Output, decodeInmRegSel_Output;

	logic			 decodeMemtoRegD_Output, decodeALUSrcE_Output, decodeRegWriteD_Output, decodePlusOne_Output,
	             decodeBranchTake_Output, decodePCSrcW_Output, decodePipeRegWriteD_Output,
					 decodePipePlusOne_Output, decodePipeBranchTake_Output, decodePipePCSrcW_Output,
					 decodePipeALUSrcE_Output, decodePipeMemtoRegD_Output;

	//Components

	Control_unit
	controlUnit(
					.funct(Funct),
 	        .opcode(Op),
					.ALUSrcE(decodeALUSrcE_Output),
					.ALUControlE(decodeALUControlE_Output),
					.MemToRegD(decodeMemtoRegD_Output),
					.RegSrcD(decodeRegSrcD_Output),
					.ImmSrcD(decodeInmRegSel_Output),
					.RegWriteD(decodeRegWriteD_Output),
					.PlusOne(decodePlusOne_Output),
					.BranchTakenE(decodeBranchTake_Output),
					.PCSrcW(decodePCSrcW_Output));

	mux2x1
	#(4)
	decodeMux2x1ToRA1D(.a(decodeMux2x1ToRA1D_IN1),
	                   .b(15),
							 .ctrl(decodeRegSrcD_Output[0]),
							 .y(decodeMux2x1ToRA1D_Output));

	mux2x1
	#(4)
	decodeMux2x1ToRA2D(.a(decodeMux2x1ToRA2D_IN1),
	                   .b(decodeMux2x1ToRA2D_IN2),
							 .ctrl(decodeRegSrcD_Output[1]),
							 .y(decodeMux2x1ToRA2D_Output));

	extend
	extendUnit(.instruction(ExtendedIN),
	           .immSrc(decodeInmRegSel_Output),
				  .extImm(decodeExtended_Output));

	registerFile
	registerFileUnit(.clk(clk),
						  .we(RegWriteW),
						  .a1(decodeMux2x1ToRA1D_Output),
						  .a2(decodeMux2x1ToRA2D_Output),
						  .a3(decodeMux2x1ToRA3D_Output),
						  .wa(WA3W),
						  .wd(ResultW),
						  .r15(PCPlus8D),
						  .rd1(decodeRD1_Output),
						  .rd2(decodeRD2_Output),
						  .rd3(decodeRD3_Output));

	pipeDecoExe
	pipeDE(.clk(clk),
			 .rst(reset),
			 .dataRegAIn(decodeRD1_Output),
			 .dataRegBIn(decodeRD2_Output),
			 .dataRegCIn(decodeRD3_Output),
			 .extIn(decodeExtended_Output),
			 .dataRegAOut(decodePipeRA_Output),
			 .dataRegBOut(decodePipeRB_Output),
			 .dataRegCOut(decodePipeRC_Output),
			 .extOut(decodePipeExtended_Output),
			 .WA3EIn(decodeMux2x1ToRA2D_IN2),
			 .WA3EOut(decodeWA3E_Output),
			 .ALUControlEIn(decodeALUControlE_Output),
			 .ALUControlEOut(decodePipeALUControlE_Output),
			 .flagsEIn(flagsEin),
			 .flagsEOut(decodePipeFlagsE_Output),
			 .RegWriteDIn(decodeRegWriteD_Output),
			 .PlusOneIn(decodePlusOne_Output),
			 .BranchTakenEIn(decodeBranchTake_Output),
			 .PCSrcWIn(decodePCSrcW_Output),
			 .ALUSrcEIn(decodeALUSrcE_Output),
			 .MemToRegDIn(decodeMemtoRegD_Output),
			 .RegWriteDOut(decodePipeRegWriteD_Output),
			 .PlusOneOut(decodePipePlusOne_Output),
			 .BranchTakenEOut(decodePipeBranchTake_Output),
			 .PCSrcWOut(decodePipePCSrcW_Output),
			 .ALUSrcEOut(decodePipeALUSrcE_Output),
			 .MemToRegDOut(decodePipeMemtoRegD_Output),
			 .CondEIn(CondE),
			 .CondEOut(decodePipeCondE_Output));

	//Set output signals

	assign WA3E  	 		  = decodeWA3E_Output;
	assign RD1  	 		  = decodePipeRA_Output;
	assign RD2 		 		  = decodePipeRB_Output;
	assign RD3 		 		  = decodePipeRC_Output;
	assign Extended 		  = decodePipeExtended_Output;
	assign flagsEout       = decodePipeFlagsE_Output;
	assign ALUSrcE         = decodePipeALUSrcE_Output;
	assign ALUControlE     = decodePipeALUControlE_Output;
	assign MemToRegD       = decodePipeMemtoRegD_Output;
	assign RegWriteD       = decodePipeRegWriteD_Output;
	assign PlusOne         = decodePipePlusOne_Output;
	assign BranchTakenE    = decodePipeBranchTake_Output;
	assign PCSrcW          = decodePipePCSrcW_Output;
	assign CondEPipeOutput = decodePipeCondE_Output;

endmodule
