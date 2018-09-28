module fetchDecoTB();
// All
logic clock;
// fetch deco
logic reset;
logic enable;
logic [0:31] instMem;
logic [0:31] instruction;

pipeFetchDeco dut(.clk(clock), .rst(reset), .E(enable), .instIn(instMem), .instOut(instruction));

//######TEST BENCH pipe Fetch Deco
initial
begin
	//Fetch Deco
	clock=0;
	reset=0;
	#5
	reset=1;
	enable = 1;
	instMem = 32'b10001000100010001000100010001000;
	instruction = 0;
	#15
	instMem = 32'b10101010101010101010101010101010;
	#5
	enable = 0;
	#10
	instMem = 32'b10101010101010101010101010101010;
	#10
	enable = 1;
	instMem = 32'b11111111111111111111111111111111;
	#8
	
	
end



always
begin
	clock <= 1;
	#5 
	clock <= 0;
	#5;
end
endmodule
