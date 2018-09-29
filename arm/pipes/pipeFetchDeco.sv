module pipeFetchDeco(
	input logic clk,
	input logic clr,
	input logic E,

	input logic [0:31] instIn,
	output logic [0:31] instOut
);

logic [0:31] inst;

always_ff @(posedge clk or negedge clr)
begin
	if(~clr)
		begin
		inst <= 0;
		end
	else
		begin
		if(E)
			begin
			inst <= instIn;
			end
		end
end

assign instOut = inst;

endmodule
