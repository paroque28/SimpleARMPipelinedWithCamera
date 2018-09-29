module decode(input  logic			 Clk, Rst, RegWriteW, ALUSrcEin, RegWriteDin, PlusOnein, MemSelEin, //Agregar ALUSrcE, RegWriteD, PlusOne, MemSelE a pipe
				  input  logic [31:0] Instruction, ResultW, PCPlus8D,
				  input  logic [3:0]	 WA3W, ALUControlEin,
				  input  logic [4:0]	 RdDin,																			//Agregar RdD a pipe
				  input  logic [1:0]  MemRd, MemtoRegW, RegSrcD,											//Agregar MemRd, MemtoRegW, RegSrcD a pipe
				  output logic [3:0]  WA3E, ALUControlEout,									//Agregar ALUControlE a pipe	
				  output logic [4:0]  RdDout,													//Agregar RdD a pipe
				  output logic [31:0] RD1, RD2, Extended,
				  output logic 		 CondEPipeOutput, ALUSrcEout, RegWriteDout, PlusOneout, MemSelEout);		//Agregar CondEPipeOutput, ALUSrcE, RegWriteD, PlusOne, MemSelE  a pipe

				  
	//Instruction Mapping
	
	logic [1:0]  Op;
	logic [5:0]  Funct;
	logic [3:0]  Rd, CondE, decodeMux2x1ToRA1D_IN1, decodeMux2x1ToRA2D_IN1, decodeMux2x1ToRA2D_IN2;
	logic [23:0] ExtendedIN;
	
	assign Op 	 						= Instruction[27:26]; //Cambiar mapeo
	assign Funct 						= Instruction[25:20]; //Cambiar mapeo
	assign Rd    						= Instruction[15:12]; //Cambiar mapeo
	assign CondE 						= Instruction[31:28];
	assign decodeMux2x1ToRA1D_IN1 = Instruction[19:16];
	assign decodeMux2x1ToRA2D_IN1 = Instruction[3:0];
	assign decodeMux2x1ToRA2D_IN2 = Instruction[15:12];
	assign ExtendedIN 				= Instruction[23:0];
	
	//Outputs
	
	logic [3:0]  decodeMux2x1ToRA1D_Output, decodeMux2x1ToRA2D_Output, decodeWA3E_Output, decodeALUControlE_Output;
	logic [31:0] decodeExtended_Output, decodeRD1_Output, decodeRD2_Output, decodePipeRA_Output, decodePipeRB_Output, decodePipeExtended_Output;
	logic [1:0]  decodeRegSrcD_Output, decodeMemRD_Output, decodeMemtoRegW_Output;
	logic			 decodeALUSrcE_Output, decodeRegWriteD_Output, decodePlusOne_Output, decodeInmRegSel_Output, decodeMemSelE_Output;  //decodeInmRegSel_Output hay que cambiar el tamanyo y verificarlo No se si es de 1 bit o 2
	logic [4:0]  decodeRdD_Output;
	
	//Components
	
	Control_unit
	controlUnit(Clk, Funct, Op, Rd, decodeALUSrcE_Output, decodeALUControlE_Output, decodeMemRD_Output, decodeMemtoRegW_Output, decodeRegSrcD_Output, decodeRegWriteD_Output, decodeRdD_Output, decodePlusOne_Output, decodeInmRegSel_Output, decodeMemSelE_Output);
	
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
	pipeDE(Clk, Rst, decodeRD1_Output, decodePipeRA_Output, decodeRD2_Output, decodePipeRB_Output, decodeExtended_Output, decodePipeExtended_Output, decodeMux2x1ToRA2D_IN2, decodeWA3E_Output);
	
	//Set output signals
	
	assign WA3E  	 = decodeWA3E_Output;
	assign RD1  	 = decodePipeRA_Output;
	assign RD2 		 = decodePipeRB_Output;
	assign Extended = decodePipeExtended_Output;
	//assign ALUControlEout = //;
	//assign RdDout = //;
	//assign CondEPipeOutput = //;
	//assign ALUSrcEout = //;
	//assign RegWriteDout = //;
	//assign PlusOneout = //;
	//assign MemSelEout = //;

endmodule 