module execute(input  logic Clk,
							reset,
							RegWriteE,
							PlusOneIn,
							BranchE,
							PCSrcE,
							ALUSrcE,
							MemToRegE,
							FlagWriteEin,
							MemWriteDin,
input logic [1:0] ForwardAE,
				  ForwardBE,

input  logic [31:0] dataRegAIn,
				  	dataRegBIn,
					dataRegCIn,
					extIn,
					ResultW,
					ADataMem, //DEBERIA ESTAR DENTRO DEL PIPE Y NO SER SALIDA

input  logic [3:0]	WA3E,
					ALUControlE,
					flagsE,
					CondE,
					
//################ Outputs ##########################
output logic [3:0]  WA3Mout,
					flagsEout,

output logic [31:0] ALUResultE,
					AToMemout,
					WDToMemout,

output logic        PCSrcMout,
					RegWriteMout,
					MemToRegMout,
					BranchTakenE,
					MemWriteEout
											);

	//Outputs

	logic [31:0] executeALUResult_Output,
							 executeMUXOut_Output,
							 executeMUX3x1AOut_Output,
	             executeMUX3x1BOut_Output,
							 executePipeADataToMem_Output,
							 executePipeWDDataToMem_Output;

	logic [3:0] executeALUFlags_Output,
							executePipeWA3M_Output,
							executeCondUnit_flags_Output;

	logic executeCondUnit_condExe_Output,
				executeANDPCSrcM_Output,
				executeANDRegWriteM_Output,
				executePipePCSrcMout_Output,
				executePipeRegWriteMout_Output,
				executePipeMemToRegMout_Output;

	//Components

	ALU
	alu(.inputA(executeMUX3x1AOut_Output),
	    .inputB(executeMUXOut_Output),
		  .inputC(dataRegCIn),
		  .ALU_control(ALUControlE),
		  .ALU_flags(executeALUFlags_Output),
		  .outputC(executeALUResult_Output));

   mux3x1
	executeMux3x1ToALUA(.a(dataRegAIn),
	                    .b(ResultW),
						.c(ADataMem),
						.ctrl(ForwardAE),
						.y(executeMUX3x1AOut_Output));

	mux3x1
	executeMux3x1ToALUB(.a(dataRegBIn),
	                    .b(ResultW),
							  .c(ADataMem),
							  .ctrl(ForwardBE),
							  .y(executeMUX3x1BOut_Output));

	mux2x1
	#(32)
	executeMux2x1ToALU(.a(executeMUX3x1BOut_Output),
							 .b(extIn),
							 .ctrl(ALUSrcE),
							 .y(executeMUXOut_Output));

	cond_unit
	executeCondUnit(.clk(Clk),.reset(reset),.flagsE_in(flagsE),
	                .ALU_flags(executeALUFlags_Output),
						 .condE(CondE),
						 .FlagWriteE(FlagWriteEin),
						 .condEx(executeCondUnit_condExe_Output),
						 .flagsE_out(executeCondUnit_flags_Output));

	//ANDS
	assign executeANDPCSrcM_Output    = PCSrcE      &&    executeCondUnit_condExe_Output;
	assign executeANDRegWriteM_Output = RegWriteE   &&    executeCondUnit_condExe_Output;
	assign BranchTakenE               = BranchE     &&    executeCondUnit_condExe_Output;

	pipeExeMem
	pipeEM(	 .clk(Clk),
	 		 .MemWriteMin(MemWriteDin),
			 .MemToRegMin(MemToRegE),
	         .ALUResultE(ALUResultE),
			 .WA3E(WA3E),
			 //________ OUTPUTS ______
			 .WriteDataE(executeMUX3x1BOut_Output),
			 .PCSrcMin(executeANDPCSrcM_Output),
			 .RegWriteMin(executeANDRegWriteM_Output),
			 .ADataMemory(executePipeADataToMem_Output),
			 .WDDataMemory(executePipeWDDataToMem_Output),
			 .WA3M(executePipeWA3M_Output),
			 .PCSrcMout(executePipePCSrcMout_Output),
			 .RegWriteMout(executePipeRegWriteMout_Output),
			 .MemToRegMout(executePipeMemToRegMout_Output),
			
		 	 .MemWriteMout(MemWriteEout));

	//Assign outputs
	assign WA3Mout      = executePipeWA3M_Output;
	assign flagsEout    = executeCondUnit_flags_Output;
	assign AToMemout    = executePipeADataToMem_Output;
	assign WDToMemout   = executePipeWDDataToMem_Output;
	assign PCSrcMout    = executePipePCSrcMout_Output;
	assign RegWriteMout = executePipeRegWriteMout_Output;
	assign MemToRegMout = executePipeMemToRegMout_Output;
	assign ALUResultE 	= executeALUResult_Output;
	

endmodule
