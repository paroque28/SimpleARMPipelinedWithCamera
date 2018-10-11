module memory (
  input logic clock,
              reset,
              PlusOne,
				      MemWriteMin,

  input logic MemToRegIn,
              PCSrcIn,
              RegWriteM,
				  
  input logic [31:0] ALUOutM,
                     WriteDataM,
                     ReadDataM,
  input logic [3:0] WA3Min,

  output logic MemToRegOut,
               PCSrcOut,
               RegWriteW,
					MemWriteMOut,

  output logic [31:0] writeData,
                      ALUOutW,
                      ReadDataW,
  output logic [3:0]  WA3Wout
  );

  logic [31:0] WDataPlusOne;

  assign WDataPlusOne = WriteDataM + 1;
  assign MemWriteMOut = MemWriteMin;

  mux2x1 #(32) mux7 (.a(WriteDataM),
                     .b(WDataPlusOne),
                     .ctrl(PlusOne),
                     .y(writeData));

//MEMORY Retorna

 pipeMemWB pipeMEM (.clk(clock), .reset(reset),
                     .RD(ReadDataM),
                     .ALUOutM(ALUOutM),
                     .MemToRegIn(MemToRegIn),
                     .WA3M(WA3Min),
                     .PCSrcIn(PCSrcIn),
                     .MemToRegOut(MemToRegOut),
                     .ReadDataW(ReadDataW),
                     .ALUOutW(ALUOutW),
                     .WA3W(WA3Wout),
                     .RegWriteIn(RegWriteM),
                     .RegWriteOut(RegWriteW),
                     .PCSrcOut(PCSrcOut)
);


endmodule
