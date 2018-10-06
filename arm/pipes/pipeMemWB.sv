module pipeMemWB (    input             clk,
					  input				reset,
                      input  [31:0]     RD,
                      input  [31:0]     ALUOutM,
                      input  [3:0]      WA3M,
                      input             MemToRegIn,RegWriteIn,
                      output logic [31:0] ReadDataW,
                      output logic [31:0] ALUOutW,
                      output logic [3:0]  WA3W,
					  output logic        MemToRegOut,RegWriteOut
 );


	logic [31:0] dataMemory;
	logic [31:0] resultALU;
	logic [3:0]  WAData;
	logic [3:0]  MemToReg;
	logic RegWrite;
	initial begin
		ReadDataW 	<= 0;
		resultALU 	<= 0;
		WAData 	  	<= 0;
		MemToReg  	<= 0;
		RegWrite  	<= 0;
		MemToRegOut <= 0;
		RegWriteOut <= 0;
		WA3W		<= 0;
		ALUOutW		<= 0;

	end
	always_ff @(posedge clk)
	begin

		dataMemory <= RD;
		resultALU  <= ALUOutM;
		WAData     <= WA3M;
		MemToReg <= MemToRegIn;
		RegWrite <= RegWriteIn;
	end

	always_ff @(negedge clk)
	begin

		ReadDataW <= dataMemory;
		ALUOutW   <= resultALU;
		WA3W      <= WAData;
		MemToRegOut <= MemToReg;
		RegWriteOut <= RegWrite;

	end


endmodule
