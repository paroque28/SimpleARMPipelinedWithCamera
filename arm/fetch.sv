

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
  output logic [31:0] pcPlus4D
  );

  logic [31:0] dirPC,
               pcPlus4,
               mux1Out,
               dirMem;


  assign PC = dirMem;
  assign pcPlus4D = pcPlus4;

  pc PCreg (
          .clk(clock),
          .enable(pcEnable),
          .dirIn(dirPC),
          .dirOut(dirMem) );

  pipeFetchDeco pipe (.clk(clock),
                      .clr(rst),
                      .E(pipeEnable),
                      .instIn(instPipeIn),
                      .instOut(instPipeOut)
                      );


  mux2x1 mux1 (.a(mux1ResultW),
               .b(pcPlus4),
               .ctrl(ctrlMux1),
               .y(mux1Out)
               );

  mux2x1 mux2 (.a(mux1Out),
                .b(mux2_aluresult),
                .ctrl(Branch),
                .y(dirPC)
                );

  adder #(32)add4(.a(dirMem), .b(4), .c(pcPlus4));

endmodule
