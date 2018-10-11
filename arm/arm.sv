module arm(
    input logic clk,
					 reset,

	 input logic [31:0] Instruction,
						     ReadData,
    output logic write_enable,

	 output logic [31:0] WriteData,
								ALUResult,
								PC
   //Write enable
);

  logic [31:0] ALUOutM,
               ALUOutE,
               ALUResultE,
               ReadDataW,
               InstMem, //Dato q sale da la memoria
               pcPlus8D,
               R15,
               dataRegAD,
               dataRegBD,
               dataRegCD,
               ExtensionD,
               ResultW;

  logic [3:0] flagsE,
              flagsD,
              ALUControlD,
              CondE;


  logic MemToRegM,
        MemToRegW,
        PCSrcW,
        BranchE,
        WA3E_W,
        RegWriteW,
        WA3E_D,
        plusOneD,
        BranchD,
        PCSrcD,
        ALUSrcD,
        FlagWriteD,
        BranchTakenE,
        RegWriteD,
        MemWriteD;


  fetch stageFetch(
        //Inputs
        .clock(clk),
        .rst(reset),
        .pipeEnable(1),
        .pcEnable(1),
        .pcSrcW(PCSrcW),
        .Branch(BranchTakenE),
        .mux1ResultW(ResultW),
        .mux2_aluresult(ALUResultE),
        .instPipeIn(Instruction),
        //Outputs
        .PC(PC),
        .instPipeOut(InstMem),
        .pcPlus8D(pcPlus8D)
        );

  decode stageDeco(

        //inputs
        .clk(clk),
        .reset(reset),
        .RegWriteW(RegWriteW),
        .Instruction(InstMem),
        .ResultW(ResultW),
        .PCPlus8D(pcPlus8D),
        .flagsEin(flagsE), //Flags que vienen de la condition unit
        .WA3W(ResultW),
        //Outputs
        .WA3E(WA3E_D),
        .CondEPipeOutput(CondE),
        .flagsEout(flagsD),
        .ALUControlE(ALUControlD),
        .RD1(dataRegAD),
        .RD2(dataRegBD),
        .RD3(dataRegCD),
        .Extended(ExtensionD),
        .ALUSrcE(ALUSrcD),
        .MemToRegD(),
        .RegWriteD(RegWriteD),
        .PlusOne(plusOneD),
        .BranchE(BranchD),
        .PCSrcD(PCSrcD)
  );

  execute stageExe(
        //Inputs
        .Clk(clk),
        .reset(reset),
        .RegWriteE(RegWriteD),
        .PlusOneIn(plusOneD),
        .BranchE(BranchD),
        .PCSrcE(PCSrcD),
        .ALUSrcE(ALUSrcD),
        .MemToRegE(),
        .FlagWriteEin(),
        .ForwardAE(0),
        .ForwardBE(0),
        .dataRegAIn(dataRegAD),
        .dataRegBIn(dataRegBD),
        .dataRegCIn(dataRegCD),
        .extIn(ExtensionD),
        .ResultW(ResultW),
        //Salida del pipe ExeMemory recibe ALUResult del ciclo adelante
        .ADataMem(ALUOutM),
        .WA3E(WA3E_D),
        .ALUControlE(ALUControlD),
        .flagsE(flagsD),
        .CondE(CondE),
        //Outputs
        .WA3Mout(),
        .flagsEout(flagsE),
        .MemWriteDin(MemWriteD),

        //Outputs ALUResultE

        .ALUResultE(ALUResultE),
        //Salida del pipe. Guarda la salida de la ALU y Address de la memoria de datos
        .AToMemout(ALUOutE),
        .WDToMemout(),
        .PCSrcMout(),
        .RegWriteMout(),
        .MemToRegMout(),
        .BranchTakenE(BranchTakenE),
        .MemWriteEout(MemWriteE)

  );
  memory stageMem(
        //Inputs
        .clock(clk),
        .reset(reset),
        .writeEnableIn(MemWriteE),
        .PlusOne(1'b0),
        .ALUOutM(ALUOutE),
        .WA3Min(),
        .WriteDataM(),
        .ReadDataM(ReadData),
        .MemToRegIn(),
        .PCSrcIn(),
        .RegWriteM(),

        // Outputs
        .MemToRegOut(MemToRegW),
        .PCSrcOut(PCSrcW),
        .RegWriteW(RegWriteW),
        .writeData(WriteData),
        .ALUOutW(ALUOutM),
        .ReadDataW(ReadDataW),
        .WA3Wout(WA3E_W),
		    .MemWriteMOut(write_enable)

  );
// Write back stage
  mux2x1 #(32) ResultWMux (
        .a(ReadDataW),
        .b(ALUOutM),
        .ctrl(MemToRegW),
        .y(ResultW)
  );
  assign ALUResult = ALUResultE ;

endmodule
