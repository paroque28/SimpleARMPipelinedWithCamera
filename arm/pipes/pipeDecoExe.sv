module pipeDecoExe(
	input logic clk,
	input logic rst,

	input logic [31:0] dataRegAIn, dataRegBIn,extIn,
	output logic [31:0] dataRegAOut, dataRegBOut,extOut,

	input logic [3:0] WA3EIn,
	output logic [3:0] WA3EOut,

	input logic [3:0]ALUControlEIn,
	output  logic [3:0]ALUControlEOut,

	input logic [3:0]flagsEIn,
	output  logic [3:0]flagsEOut,

	input logic [3:0] CondEIn,
	output  logic [3:0] CondEOut,

	input logic RegWriteDIn, PlusOneIn, BranchTakenEIn, PCSrcWIn, ALUSrcEIn, MemToRegDIn,
	output logic RegWriteDOut, PlusOneOut, BranchTakenEOut, PCSrcWOut, ALUSrcEOut, MemToRegDOut
);

logic [31:0] dataRegA;
logic [31:0] dataRegB;
logic [3:0] WA3E;
logic [31:0] ext;
logic [3:0] ALUControlE;
logic [3:0] flagsE;
logic [3:0] CondE;


logic RegWriteD, PlusOne, BranchTakenE, PCSrcW, ALUSrcE, MemToRegD;


always_ff @(posedge clk or negedge rst)
begin
	if(~rst)
		begin
		dataRegA <= 0;
		dataRegB <= 0;
		ext <= 0;
		WA3E <= 0;
		ALUControlE <= 0;
		RegWriteD <= 0;
		PlusOne <= 0;
		BranchTakenE <= 0;
		PCSrcW <= 0;
		ALUSrcE <= 0;
		MemToRegD <= 0;
		flagsE <= 0;
		CondE <= 0;

		end
	else
		begin
		dataRegA <= dataRegAIn;
		dataRegB <= dataRegBIn;
		ext <= extIn;
		WA3E <= WA3EIn;
		ALUControlE <= ALUControlEIn;
		RegWriteD <= RegWriteDIn;
		PlusOne <= PlusOneIn;
		BranchTakenE <= BranchTakenEIn;
		PCSrcW <= PCSrcWIn;
		ALUSrcE <= ALUSrcEIn;
		MemToRegD <= MemToRegDIn;
		flagsE <= flagsEIn;
		CondE <= CondEIn;

		end
end

always_ff @(negedge clk)
begin
	dataRegAOut <= dataRegA;
	dataRegBOut <= dataRegB;
	WA3EOut <= WA3E;
	extOut <= ext;
	ALUControlEOut <= ALUControlE;
	RegWriteDOut <= RegWriteD;
	PlusOneOut <= PlusOne;
	BranchTakenEOut <= BranchTakenE;
	PCSrcWOut <= PCSrcW;
	ALUSrcEOut <= ALUSrcE;
	MemToRegDOut <= MemToRegD;
	flagsEOut <= flagsE;
	CondEOut <= Cond;
end

endmodule
