

module fetch(
  input logic clock,
  input logic clearPipe,
  input logic pipeEnable,
  input logic pcEnable,
  input logic ctrlMux1, //Control
  input logic ctrlMux2, //Control
  input logic [31:0] mux1PcPlus8,
  input logic [31:0] mux1ResultW,
  input logic [31:0] mux2_aluresult,
  input logic [31:0] instPipeIn,
  output logic [31:0] PC,
  output logic [31:0] instPipeOut,
  output logic [31:0] pcPlus4
  );

  logic [31:0] dirPC;
  logic [31:0] mux1Out;
  logic [31:0] dirMem;

  assign PC = dirMem;

  pc PCreg (
          .clk(clock),
          .enable(pcEnable),
          .dirIn(dirPC),
          .dirOut(dirMem) );

  pipeFetchDeco pipe (.clk(clock),
                      .clr(clearPipe),
                      .E(pipeEnable),
                      .instIn(instPipeIn),
                      .instOut(instPipeOut)
                      );


  mux2x1 mux1 (.a(mux1PcPlus8),
               .b(mux1ResultW),
               .ctrl(ctrlMux1),
               .y(mux1Out)
               );

  mux2x1 mux2 (.a(mux1Out),
                .b(mux2_aluresult),
                .ctrl(ctrlMux2),
                .y(dirPC)
                );

  adder #(32)add4(.a(dirMem), .b(4), .c(pcPlus4));

endmodule
