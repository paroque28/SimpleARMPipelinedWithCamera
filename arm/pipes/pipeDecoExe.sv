module pipeDecoExe(
	input logic clk,
	input logic rst,

	input logic [31:0] dataRegAIn, dataRegBIn, dataRegCIn, extIn,
	output logic [31:0] dataRegAOut, dataRegBOut, dataRegCOut,extOut,

	input logic [3:0] WA3EIn,
	output logic [3:0] WA3EOut,

	input logic [3:0]ALUControlEIn,
	output  logic [3:0]ALUControlEOut,

	input logic [3:0]flagsEIn,
	output  logic [3:0]flagsEOut,

	input logic [3:0] CondEIn,
	output  logic [3:0] CondEOut,

	input logic RegWriteDIn, PlusOneIn, BranchEIn, PCSrcDIn, ALUSrcEIn, MemToRegDIn,
	output logic RegWriteDOut, PlusOneOut, BranchEOut, PCSrcDOut, ALUSrcEOut, MemToRegDOut,
	input logic [1:0] FlagWDIn,
	output logic [1:0] FlagWEOut
);

logic [31:0] dataRegA, dataRegB, dataRegC;
logic [3:0] WA3E;
logic [31:0] ext;
logic [3:0] ALUControlE;
logic [3:0] flagsE;
logic [3:0] CondE;
logic [1:0] FlagW;


logic RegWriteD, PlusOne, BranchE, PCSrcD, ALUSrcE, MemToRegD;


always_ff @(posedge clk or posedge rst)
begin
	if(rst)
		begin
		dataRegA <= 0;
		dataRegB <= 0;
		dataRegC <= 0;
		ext <= 0;
		WA3E <= 0;
		ALUControlE <= 0;
		RegWriteD <= 0;
		PlusOne <= 0;
		BranchE <= 0;
		PCSrcD <= 0;
		ALUSrcE <= 0;
		MemToRegD <= 0;
		flagsE <= 0;
		CondE <= 0;
		FlagW <= 0;
		end
	else
		begin
		dataRegA <= dataRegAIn;
		dataRegB <= dataRegBIn;
		dataRegC <= dataRegCIn;
		ext <= extIn;
		WA3E <= WA3EIn;
		ALUControlE <= ALUControlEIn;
		RegWriteD <= RegWriteDIn;
		PlusOne <= PlusOneIn;
		BranchE <= BranchEIn;
		PCSrcD <= PCSrcDIn;
		ALUSrcE <= ALUSrcEIn;
		MemToRegD <= MemToRegDIn;
		flagsE <= flagsEIn;
		CondE <= CondEIn;
		FlagW <= FlagWDIn;
		end
end

always_ff @(negedge clk)
begin
	if (rst)
	begin
		dataRegAOut 	<= 0;
		dataRegBOut 	<= 0;
		dataRegCOut 	<= 0;
		WA3EOut 		<= 0;
		extOut 			<= 0;
		ALUControlEOut 	<= 0;
		RegWriteDOut 	<= 0;
		PlusOneOut		<= 0;
		BranchEOut 		<= 0;
		PCSrcDOut 		<= 0;
		ALUSrcEOut 		<= 0;
		MemToRegDOut 	<= 0;
		flagsEOut 		<= 0;
		CondEOut 		<= 0;
		FlagWEOut 		<= 0;
	end

	else begin
		dataRegAOut <= dataRegA;
		dataRegBOut <= dataRegB;
		dataRegCOut <= dataRegC;
		WA3EOut <= WA3E;
		extOut <= ext;
		ALUControlEOut <= ALUControlE;
		RegWriteDOut <= RegWriteD;
		PlusOneOut <= PlusOne;
		BranchEOut <= BranchE;
		PCSrcDOut <= PCSrcD;
		ALUSrcEOut <= ALUSrcE;
		MemToRegDOut <= MemToRegD;
		flagsEOut <= flagsE;
		CondEOut <= CondE;
		FlagWEOut <= FlagW;
	end
end

endmodule
