module pipeDecoExe(
	input logic clk,
	input logic rst,

	input logic [31:0] dataRegAIn,
	output logic [31:0] dataRegAOut,

	input logic [31:0] dataRegBIn,
	output logic [31:0] dataRegBOut,

	input logic [31:0] extIn,
	output logic [31:0] extOut,

	input logic [3:0] WA3EIn,
	output logic [3:0] WA3EOut
);

logic [31:0] dataRegA;
logic [31:0] dataRegB;
logic [3:0] WA3;
logic [31:0] ext;

always_ff @(posedge clk or negedge rst)
begin
	if(~rst)
		begin
		dataRegA <= 0;
		dataRegB <= 0;
		ext <= 0;
		WA3 <= 0;
		end
	else
		begin
		dataRegA <= dataRegAIn;
		dataRegB <= dataRegBIn;
		ext <= extIn;
		WA3 <= WA3In;
		end
end

always_ff @(negedge clk)
begin
	dataRegAOut <= dataRegA;
	dataRegBOut <= dataRegB;
	WA3EOut <= WA3;
	extOut <= ext;
end

endmodule
