module pipeMemWB (input         clk,
					  input  [31:0] RD,
					  input  [31:0] ALUOutM,
					  input  [3:0]  WA3M,
						input  [3:0] MemToRegIn,
					  output [31:0] ReadDataW,
					  output [31:0] ALUOutW,
					  output [3:0]  WA3W,
						output [3:0] MemToRegOut);


	logic [31:0] dataMemory;
	logic [31:0] resultALU;
	logic [3:0]  WAData;
	logic [3:0]  MemToReg;

	always_ff @(posedge clk)
	begin

		dataMemory <= RD;
		resultALU  <= ALUOutM;
		WAData     <= WA3M;
		MemToReg <= MemToRegIn;

	end

	always_ff @(negedge clk)
	begin

		ReadDataW <= dataMemory;
		ALUOutW   <= resultALU;
		WA3W      <= WAData;
		MemToRegOut <= MemToReg;

	end


endmodule
