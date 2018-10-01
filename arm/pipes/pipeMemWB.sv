module pipeMemWB (input         clk,
					  input  [31:0] RD,
					  input  [31:0] ALUOutM,
					  input  [3:0]  WA3M,
					  output [31:0] ReadDataW,
					  output [31:0] ALUOutW,
					  output [3:0]  WA3W);


	logic [31:0] dataMemory;
	logic [31:0] resultALU;
	logic [3:0]  WAData;


	always_ff @(posedge clk)
	begin

		dataMemory <= RD;
		resultALU  <= ALUOutM;
		WAData     <= WA3M;

	end

	always_ff @(negedge clk)
	begin

		ReadDataW <= dataMemory;
		ALUOutW   <= resultALU;
		WA3W      <= WAData;

	end


endmodule
