module arm(
   input logic clk, reset, 
	 input logic [31:0] Instruction, ReadData,
     output logic write_enable,
	 output logic [31:0] WriteData, ALUResult, PC
);
  logic [31:0] ALUOutM;
  logic [31:0] ReadDataW;
  logic [31:0] InstMem; //Dato q sale da la memoria
  logic [31:0] pc_4;
  logic [31:0] R15;
  logic [31:0] dataRegAD, dataRegBD, dataRegCD, ExtensionD;
  logic [3:0] flags, ALUControlD, CondE;
  logic MemToRegM, MemToRegW, PCSrcW;
  logic BranchE, WA3E_W,WA3E_D, RegWriteW;


  fetch stageFetch(
        .clock(clk),
        .mux1PcPlus8(pc_4),
        .PC(PC),
        .ctrlMux1(PCSrcW),
        .ctrlMux2(BranchE),
        .mux1ResultW(ResultW),
        .mux2_aluresult(WA3E_W),
        .instPipeIn(Instruction),
        .instPipeOut(InstMem),
        .pcPlus4(pc_4)
        );
  decode stageDeco(
        .Clk(clk),
        //.Rst(hazard)
        .Instruction(InstMem),
        .ResultW(ResultW),
        .PCPlus8D(pc_4),
        .WA3W(WA3E_W),
        .flagsEin(flags), //Flags que vienen de la condition unit
        .RegWriteW(RegWriteM),
        .WA3E(WA3E_D),
        .ALUControlE(ALUControlD),
        .CondEPipeOutput(CondE),
        .RD1(dataRegAD),
        .RD2(dataRegBD),
        .Extended(ExtensionD)
  );
  logic MemWriteM;
  execute stageExe(
        .Clk(clk),
        .reset(reset),
        .WA3E(WA3E_D),
        .ALUControlE(ALUControlD),
        .flagsE(flags),
        .CondE(CondE),
        .dataRegAIn(dataRegAD),
        .dataRegBIn(dataRegBD),
        .dataRegCIn(),
        .extIn(ExtensionD),
        .ResultW(ResultW),
        .MemWriteM(MemWriteM)

  );
  memory stageMem(
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
        .RegWriteM()
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
        .y(ALUResult)
  );

endmodule
