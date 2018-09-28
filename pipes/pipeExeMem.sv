module pipeExeMem (input         clk,
					 input  [31:0] ALUResultE,
					 input  [31:0] WriteDataE,
					 input  [3:0]  WA3E,
					 output [31:0] ADataMemory,
					 output [31:0] WDDataMemory,
					 output [3:0]  WA3M);


	logic [31:0] writeData;
	logic [31:0] resultALU;
	logic [3:0]  WAData;


	always_ff @(posedge clk)
	begin

		writeData  <= WriteDataE;
		resultALU  <= ALUResultE;
		WAData     <= WA3E;

	end

	always_ff @(negedge clk)
	begin

		ADataMemory  <= writeData;
		WDDataMemory <= resultALU;
		WA3M         <= WAData;

	end


endmodule
