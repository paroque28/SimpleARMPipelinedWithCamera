

module fetch(
  input logic clock,
  input logic reset,
  input logic pipeEnable,
  input logic pcEnable,
  input logic ALUResult,
  input logic WBResult,
  input logic [31:0] memInstruction,
  output logic [31:0] addressMem
  );


  logic [31:0] dirMem;
  logic [31:0] dirPC;
  pc PC (.clk(clock), .enable(pcEnable), .dirIn(dirPC), .dirOut(dirMem) );



endmodule
