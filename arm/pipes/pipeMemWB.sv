module pipeMemWB (    input             clk,
					  input				reset,
                      input  [31:0]     RD,
                      input  [31:0]     ALUOutM,
                      input  [3:0]      WA3M,
                      input             MemToRegIn,RegWriteIn, PCSrcIn,
                      output logic [31:0] ReadDataW,
                      output logic [31:0] ALUOutW,
                      output logic [3:0]  WA3W, 
					  output logic     MemToRegOut,  RegWriteOut, PCSrcOut

 );


	logic [31:0] dataMemory;
	logic [31:0] resultALU;
	logic [3:0]  WAData;
	logic [3:0]  MemToReg;
	logic RegWrite, PCSrc;

	always_ff @(posedge clk or posedge reset)
	begin
        if(reset) begin
            dataMemory <= 0;
            resultALU  <= 0;
            WAData     <= 0;
            MemToReg   <= 0;
            RegWrite   <= 0;
            PCSrc      <= 0;
        end
        else begin
            dataMemory <= RD;
            resultALU  <= ALUOutM;
            WAData     <= WA3M;
            MemToReg <= MemToRegIn;
            RegWrite <= RegWriteIn;
            PCSrc      <= PCSrcIn;
        end
	end

	always_ff @(negedge clk)
	begin
        if(reset) begin
            ReadDataW   <= 0;
            ALUOutW     <= 0;
            WA3W        <= 0;
            MemToRegOut <= 0;
            RegWriteOut <= 0;
            PCSrcOut    <= 0;
        end
        else begin
            ReadDataW <= dataMemory;
            ALUOutW   <= resultALU;
            WA3W      <= WAData;
            MemToRegOut <= MemToReg;
            RegWriteOut <= RegWrite;
            PCSrcOut    <= PCSrc;
        end

	end


endmodule
