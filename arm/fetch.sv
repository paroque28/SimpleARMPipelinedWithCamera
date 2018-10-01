

module fetch(
  input logic clock,
  input logic clearPipe,
  input logic pipeEnable,
  input logic pcEnable,
  input logic ctrlMux1,
  input logic ctrlMux2,
  input logic [31:0] mux1pin0,
  input logic [31:0] mux1pin1,
  input logic [31:0] mux2pin1,
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


  mux2x1 mux1 (.a(mux1pin0),
               .b(mux1pin1),
               .ctrl(ctrlMux1),
               .y(mux1Out)
               );

  mux2x1 mux2 (.a(mux1Out),
                .b(mux2pin1),
                .ctrl(ctrlMux2),
                .y(dirPC)
                );

  adder #(32)add4(.a(dirMem), .b(4), .c(pcPlus4));

endmodule
