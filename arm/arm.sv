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
        .pcPlus4D(pcPlus8D)
        );

  decode stageDeco(

        //inputs
        .clk(clk),
        .reset(reset),

        .Instruction(InstMem),
        .ResultW(ResultW),
        .PCPlus8D(pcPlus8D),
        .RegWriteW(RegWriteW),
        .flagsEin(flagsE), //Flags que vienen de la condition unit
        //Outputs
        .WA3E(WA3E_D),
        .CondEPipeOutput(CondE),
        .flagsEout(flagsD),
        .ALUControlE(ALUControlD),
        .RD1(dataRegAD),
        .RD2(dataRegBD),

        .Extended(ExtensionD),
        .PlusOne(plusOneD),
        .BranchTakenE(BranchD),
        .PCSrcW(PCSrcD),
        .ALUSrcE(ALUSrcD)

  );

  execute stageExe(
        //Inputs
        .Clk(clk),
        .reset(reset),

        .dataRegAIn(dataRegAD),
        .dataRegBIn(dataRegBD),
        .extIn(ExtensionD),
        .ResultW(ResultW),
        .PlusOneIn(plusOneD),
        .BranchE(BranchD),
        .PCSrcE(PCSrcD),
        .ALUSrcE(ALUSrcD),
        //Salida del pipe ExeMemory recibe ALUResult del ciclo adelante
        .ADataMem(ALUOutM),
        .WA3E(WA3E_D),
        .ALUControlE(ALUControlD),
        .flagsE(flagsD),
        .CondE(CondE),
        .flagsEout(flagsE),
        .MemWriteDin(MemWriteD),

        //Outputs ALUResultE

        .ALUResultE(ALUResultE),
        //Salida del pipe. Guarda la salida de la ALU y Address de la memoria de datos
        .AToMemout(ALUOutE),
        //.WDToMemout(),
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
