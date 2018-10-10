module pipeExeMem (input clk, reset, PCSrcMin, RegWriteMin, MemToRegMin, MemWriteMin,
					    input  [31:0] ALUResultE,
					    input  [31:0] WriteDataE,
					    input  [3:0]  WA3E,
					    output logic [31:0] ADataMemory,
					    output logic [31:0] WDDataMemory,
					    output logic [3:0]  WA3M,
						output logic PCSrcMout, RegWriteMout, MemToRegMout, MemWriteMout);


	logic [31:0] writeData;
	logic [31:0] resultALU;
	logic [3:0]  WAData;

	logic        tmpPCSrcMinOut, 
					 tmpRegWriteMinOut, 
					 tmpMemToRegMinOut,
					 tmpMemWriteM;


	always_ff @(posedge clk or posedge reset)
	begin
		if(reset) begin
			writeData         	<= 0;
			resultALU         	<= 0;
			WAData            	<= 0;
			tmpPCSrcMinOut    	<= 0;
			tmpRegWriteMinOut 	<= 0;
			tmpMemToRegMinOut 	<= 0;
			tmpMemWriteM		<= 0;
		end
		else begin
			writeData         	<= WriteDataE;
			resultALU         	<= ALUResultE;
			WAData            	<= WA3E;
			tmpPCSrcMinOut    	<= PCSrcMin;
			tmpRegWriteMinOut 	<= RegWriteMin;
			tmpMemToRegMinOut 	<= MemToRegMin;
			tmpMemWriteM		<=  MemWriteMin;
		end


	end

	always_ff @(negedge clk)
	begin
		if(reset) begin
			ADataMemory  <= 0;
			WDDataMemory <= 0;
			WA3M         <= 0;
			PCSrcMout    <= 0;
			RegWriteMout <= 0;
			MemToRegMout <= 0;
			MemWriteMout <= 0;
		end else begin
			ADataMemory  <= writeData;
			WDDataMemory <= resultALU;
			WA3M         <= WAData;
			PCSrcMout    <= tmpPCSrcMinOut;
			RegWriteMout <= tmpRegWriteMinOut;
			MemToRegMout <= tmpMemToRegMinOut;
			MemWriteMout <= tmpMemWriteM;
		end

	end


endmodule
