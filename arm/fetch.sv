

module fetch(
  input logic clock,
  input logic rst,
  input logic pipeEnable,
  input logic pcEnable,
  input logic pcSrcW, //Control
  input logic Branch, //Control
  input logic [31:0] mux1ResultW,
  input logic [31:0] mux2_aluresult,
  input logic [31:0] instPipeIn,
  output logic [31:0] PC,
  output logic [31:0] instPipeOut,
  output logic [31:0] pcPlus8D
  );

  logic [31:0] dirPC, pcPlus8D, pcPlus4F;
  logic [31:0] mux1Out;
  logic [31:0] dirMem;


  assign pcPlus4F = PC + 4;
  assign pcPlus8D = pcPlus4F;
  assign PC = dirMem;

  pc PCreg (
          .clk(clock),
          .enable(pcEnable),
          .dirIn(dirPC),
          .dirOut(dirMem) );

  pipeFetchDeco pipe (.clk(clock),
                      .reset(rst),
                      .E(pipeEnable),
                      .instIn(instPipeIn),
                      .instOut(instPipeOut)
                      );


  mux2x1 mux1 (.a(pcPlus4F),
               .b(mux1ResultW),
               .ctrl(pcSrcW),
               .y(mux1Out)
               );

  mux2x1 mux2 (.a(mux1Out),
                .b(mux2_aluresult),
                .ctrl(Branch),
                .y(dirPC)
                );


endmodule
