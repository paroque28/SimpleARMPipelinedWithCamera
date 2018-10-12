module arm( input logic clk,
                        reset,

            input logic [31:0] Instruction,
                              ReadData,
            output logic write_enable,

            output logic [31:0] WriteData,
                              WriteAddress,
                              PC
);

  logic [31:0] ALUOutM,
               ALUOutE,
               ALUResultE,
               ReadDataW,
               InstMem, //Dato q sale da la memoria
               WriteDataE,
               pcPlus8D,
               R15,
               dataRegAD,
               dataRegBD,
               dataRegCD,
               ExtensionD,
               ResultW;

  logic [3:0] flagsE,
              flagsD,
              WA3E_D, WA3E_E, WA3M,
              ALUControlD,
              CondE;


  logic MemToRegD, MemToRegE,  MemToRegW, 
        PCSrcE, PCSrcW,
        RegWriteD, RegWriteE, RegWriteW,
        plusOneD,
        BranchD, BranchTakenE,
        PCSrcD,
        ALUSrcD,
        MemWriteD, MemWriteE;

logic [1:0] FlagWriteE;


  fetch stageFetch(
        //Inputs
        .clock(clk),
        .rst(reset),
        .pipeEnable(1'b1),
        .pcEnable(1'b1),
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
        .WA3W(WA3M),
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
        .MemToRegD(MemToRegD),
        .RegWriteD(RegWriteD),
        .PlusOne(plusOneD),
        .BranchE(BranchD),
        .PCSrcD(PCSrcD),
        .MemWriteD(MemWriteD),
        .FlagWriteE(FlagWriteE)
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
        .MemToRegE(MemToRegD),
        .MemWriteDin(MemWriteD),
        .ForwardAE(2'b0),
        .ForwardBE(2'b0),
        .FlagWriteEin(FlagWriteE),
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
        .WA3Mout(WA3E_E),
        .flagsEout(flagsE),
        //Outputs ALUResultE
        .ALUResultE(ALUResultE),
        //Salida del pipe. Guarda la salida de la ALU y Address de la memoria de datos
        .AToMemout(ALUOutE),
        .WDToMemout(WriteDataE),
        .PCSrcMout(PCSrcE),
        .RegWriteMout(RegWriteE),
        .MemToRegMout(MemToRegE),
        .BranchTakenE(BranchTakenE),
        .MemWriteEout(MemWriteE)

  );
  memory stageMem(
        //Inputs
        .clock(clk),
        .reset(reset),
        .PlusOne(1'b0),
        .MemWriteMin(MemWriteE),
        .ALUOutM(ALUOutE),
        .WA3Min(WA3E_E),
        .WriteDataM(WriteDataE),
        .ReadDataM(ReadData),
        .MemToRegIn(MemToRegE),
        .PCSrcIn(PCSrcE),
        .RegWriteM(RegWriteE),
        

        // Outputs
        .MemToRegOut(MemToRegW),
        .PCSrcOut(PCSrcW),
        .RegWriteW(RegWriteW),
        .writeData(WriteData),
        .ALUOutW(ALUOutM),
        .ReadDataW(ReadDataW),
        .WA3Wout(WA3M),
	  .MemWriteMOut(write_enable)

  );
// Write back stage
  mux2x1 #(32) ResultWMux (
        .a(ALUOutM),
        .b(ReadDataW),
        .ctrl(MemToRegW),
        .y(ResultW)
  );
  assign WriteAddress = ALUOutM ;

endmodule
