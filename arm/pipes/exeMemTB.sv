module exeMemTB();
// All
logic clock;
//#####Exe Mem
logic [31:0] writeData;
logic [31:0] resultALU;
logic [3:0]  WAData;

//
// clk,


pipeExeMem dut(.clk(clock));

initial 
begin

end


always
begin
	clock <= 1;
	#5
	clock <= 0;
	#5;
end
endmodule
