module fetchTB();
logic clock;
logic clr;
logic pipeEnable;
logic pcEnable;
logic ctrlMux1;
logic ctrlMux2;
logic [31:0] mux1pin0;
logic [31:0] mux1pin1;
logic [31:0] mux2pin1;
logic [31:0] instPipeIn;
logic [31:0] addressMem; //OUTPUTS
logic [31:0] instPipeOut; //OUTPUTS
logic [31:0] pcPlus4; //OUTPUTS

fetch dut (.clock(clock),
          .clearPipe(clr),
          .pcEnable(pcEnable),
          .pipeEnable(pipeEnable),
          .ctrlMux1(ctrlMux1),
          .ctrlMux2(ctrlMux2),
          .mux1pin0(mux1pin0),
          .mux1pin1(mux1pin1),
          .mux2pin1(mux2pin1),
          .instPipeIn(instPipeIn),
          .addressMem(addressMem),
          .instPipeOut(instPipeOut),
          .pcPlus4(pcPlus4)
           );

initial begin
  mux1pin0 <= 32'h0001;
  mux1pin1 <= 32'h0002;
  mux2pin1 <= 32'h0003;
  instPipeIn <= 32'h000A;
  ctrlMux1 = 1;
  ctrlMux2 = 1;
  pipeEnable = 1;
  pcEnable = 1;
  clr <= 1;
  clock <= 1;
  #10
  clr <= 0;
  #10
  clr <= 1;
  #10
  ctrlMux1 = 0;
  #10
  ctrlMux1 = 1;
  ctrlMux2 = 0;
  #10
  ctrlMux2 = 1;
  #10
  instPipeIn <= 32'h000B;
  #10;
  pipeEnable <= 0;
  instPipeIn <= 32'h001A;
  #10;
  pcEnable = 0;
  pipeEnable <= 1;
  instPipeIn <= 32'h002C;
  #10
  mux2pin1 <= 32'hFFFF;
  #10
  mux2pin1 <= 32'h0004;
  pcEnable <= 1;
end

always
	begin
	clock=!clock;
	#10;
	end

endmodule
