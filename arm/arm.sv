module arm(
   input logic clk, reset,
	 input logic [31:0] Instruction, ReadData,
   output logic write_enable,
	 output logic [31:0] WriteData, ALUResult, PC
   //Write enable
);
  logic [31:0] ALUOutM;
  logic [31:0] ALUResultE;
  logic [31:0] ReadDataW;
  logic [31:0] InstMem; //Dato q sale da la memoria
  logic [31:0] pcPlus8D;
  logic [31:0] R15;
  logic [31:0] dataRegAD, dataRegBD, dataRegCD, ExtensionD;
  logic [31:0] Ae;
  logic [31:0] ResultW;
  logic [3:0] flagsE, flagsD, ALUControlD, CondE;


  logic MemToRegM, MemToRegW, PCSrcW;
  logic BranchTakenE, WA3E_W,  RegWriteW;
  logic WA3E_D, plusOneD, BranchD, PCSrcD, ALUSrcD, FlagWriteD;
  logic MemWriteM;


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

        .Instruction(InstMem),
        .ResultW(ResultW),
        .PCPlus8D(pcPlus8D),
        .RegWriteW(RegWriteW),
        .flagsEin(flags), //Flags que vienen de la condition unit
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
        //.ADataMem(),
        .WA3E(WA3E_D),
        .ALUControlE(ALUControlD),
        .flagsE(flagsD),
        .CondE(CondE),
        .flagsEout(flagsE),

        //Outputs ALUResultE

        .ALUResultE(ALUResultE),
        .AToMemout(), //Guarda la salida de la ALU y Address de la memoria de datos
        //.WDToMemout(),
        .PCSrcMout(),
        .RegWriteMout(),
        .MemToRegMout(),
        .BranchTakenE(BranchTakenE),
        .MemWriteM(MemWriteM)

  );
  memory stageMem(
        //Inputs
        .clock(clk),
        .reset(reset),
        .writeEnableIn(MemWriteM),
        .PlusOne(1'b0),
        .ALUResultEIn(),
        .WA3Min(),
        .WriteDataM(),
        .ReadDataM(ReadData),
        .MemToRegIn(),
        .PCSrcIn(),
        .RegWriteM(),
        //Outputs
        .MemToRegOut(MemToRegW),
        .PCSrcOut(PCSrcW),
        .RegWriteW(RegWriteW),
        .writeData(WriteData),
        .ALUResultMOut(ALUOutM),
        .ReadDataW(ReadDataW),
        .WA3Wout(WA3E_W)

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
