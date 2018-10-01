module memory (
  input logic clock, writeEnableIn, PlusOne,
  input logic [31:0] ALUResultEIn, WA3Min, WriteDataM, ReadDataM,
  input logic MemToRegIn,
  output logic MemToRegOut,
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
                     .MemToRegIn(MemToRegMIn),
                     .WA3M(WA3Min),
                     .MemToRegOut(MemToRegMOut),
                     .ReadDataW(ReadDataW),
                     .ALUOutW(ALUResultMOut),
                     .WA3W(WA3Wout));

//FALTA LA MEMORIA

endmodule
