module memory (
  input logic clock, writeEnableIn, PlusOne,
  input logic [31:0] ALUResultEIn, WA3Min, WriteDataM, ReadDataM,
  input logic MemToRegIn,PCSrcIn,RegWriteM,
  output logic MemToRegOut,PCSrcOut,RegWriteW,
  output logic [31:0] writeData,
  output logic [31:0] ALUResultMOut,ReadDataW, WA3Wout
  );

  logic [31:0] WDataPlusOne;

  adder #(32) AddOne(.a(WriteDataM),
                      .b(1),
                      .c(WDataPlusOne));

  mux2x1 #(32) mux7 (.a(WriteDataM),
                     .b(WDataPlusOne),
                     .ctrl(PlusOne),
                     .y(writeData));

//MEMORY Retorna

 pipeMemWB pipeMEM (.clk(clock),
                     .RD(ReadDataM),
                     .ALUOutM(ALUResultEIn),
                     .MemToRegIn(MemToRegIn),
                     .WA3M(WA3Min),
                     .MemToRegOut(MemToRegOut),
                     .ReadDataW(ReadDataW),
                     .ALUOutW(ALUResultMOut),
                     .WA3W(WA3Wout),
                     .RegWriteIn(RegWriteM),
                     .RegWriteOut(RegWriteW));


endmodule
