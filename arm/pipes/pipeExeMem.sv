module pipeExeMem (input clk, PCSrcMin, RegWriteMin, MemToRegMin,
					    input  [31:0] ALUResultE,
					    input  [31:0] WriteDataE,
					    input  [3:0]  WA3E,
					    output logic [31:0] ADataMemory,
					    output logic [31:0] WDDataMemory,
					    output logic [3:0]  WA3M,
						output logic PCSrcMout, RegWriteMout, MemToRegMout);


	logic [31:0] writeData;
	logic [31:0] resultALU;
	logic [3:0]  WAData;

	logic        tmpPCSrcMinOut, tmpRegWriteMinOut, tmpMemToRegMinOut;


	always_ff @(posedge clk)
	begin

		writeData         <= WriteDataE;
		resultALU         <= ALUResultE;
		WAData            <= WA3E;
		tmpPCSrcMinOut    <= PCSrcMin;
		tmpRegWriteMinOut <= RegWriteMin;
		tmpMemToRegMinOut <= MemToRegMin;


	end

	always_ff @(negedge clk)
	begin

		ADataMemory  <= writeData;
		WDDataMemory <= resultALU;
		WA3M         <= WAData;
		PCSrcMout    <= tmpPCSrcMinOut;
		RegWriteMout <= tmpRegWriteMinOut;
		MemToRegMout <= tmpMemToRegMinOut;


	end


endmodule
