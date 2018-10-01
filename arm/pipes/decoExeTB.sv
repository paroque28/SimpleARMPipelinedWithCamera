module decoExeTB();
// All
logic clock;

//#####Deco Exe
logic reset;
logic [0:31] dataRegA;
logic [0:31] dataRegB;
logic [0:31] A;
logic [0:31] B;
logic [0:31] extReg;
logic [0:31] ext;

pipeDecoExe dut(.clk(clock), .rst(reset), .dataRegAIn(A), .dataRegBIn(B), .dataRegBOut(dataRegB),.dataRegAOut(dataRegA),.extIn(ext), .extOut(extReg));

///####TEST BENCH pipe Deco Exe
initial
begin
	reset=0;
	#5
	reset=1;
	#5
	A= 32'hAA12;
	B= 32'hBB12;
	ext = 32'h0016;
	#100
	A= 32'h0001;
	B= 32'h0002;
	ext = 32'hFFF1;
	#5
	reset = 0;
	#5
	reset = 1;

end

always
begin
	clock <= 1;
	#5
	clock <= 0;
	#5;
end
endmodule
