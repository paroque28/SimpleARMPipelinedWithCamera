module arm(
   input logic clk,
	 input logic [31:0] Instruction, ReadData,
	 output logic [31:0] WriteData, AddressData, AddressInstru

);
  logic [31:0] ResultW;
  logic [31:0] ALUOutM;
  logic [31:0] ReadDataM;
  logic MemToRegM, MemToRegW;
  fetch stageFetch(
        .clock(clk),
        .mux1pin0(ResultW)
  );
  decode stageDeco(
        .Clk(clk),
  );
  execute stageExe(
        .Clk(clk),
  );
  memory stageMem(
        .clock(clk),
        .MemToRegOut(MemToRegW),
        .ALUResultMOut(ALUOutM),
        .ReadDataW(ReadDataM)
  );
// Write back stage
  mux2x1 #(32) ResultWMux (
        .a(ReadDataM),
        .b(ALUOutM),
        .ctrl(MemToRegW),
        .y(ResultW)
  );

endmodule
