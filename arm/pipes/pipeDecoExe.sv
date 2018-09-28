module pipeDecoExe(
	input logic clk,
	input logic rst,

	input logic [0:31] dataRegAIn,
	output logic [0:31] dataRegAOut,

	input logic [0:31] dataRegBIn,
	output logic [0:31] dataRegBOut,

	input logic [0:31]extIn,
	output logic [0:31]extOut
);

logic [0:31] dataRegA;
logic [0:31] dataRegB;
logic [0:31] ext;

always_ff @(posedge clk or negedge rst)
begin
	if(~rst)
		begin
		dataRegA <= 0;
		dataRegB <= 0;
		ext <= 0;
		end
	else
		begin
		dataRegA <= dataRegAIn;
		dataRegB <= dataRegBIn;
		ext <= extIn;
		end
end

always_ff @(negedge clk)
begin
	dataRegAOut <= dataRegA;
	dataRegBOut <= dataRegB;
	extOut <= ext;
end

endmodule
