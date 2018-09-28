module pipeFetchDeco(
	input logic clk,
	input logic rst,
	input logic enable,

	input logic [0:31] instIn,
	output logic [0:31] instOut
);

logic [0:31] inst;

always_ff @(posedge clk or posedge rst)
begin
	if(rst)
		inst <= 0;
	else
		if(enable)
			inst <= instIn;
end

always_ff @(negedge clk)
begin
	instOut <= inst;
end

endmodule
