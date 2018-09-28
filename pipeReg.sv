module pipeReg(
	input logic clk,
	input logic rst,
	
	input logic [0:31] regAIn,
	output logic [0:31] regAOut,
	
	input logic [0:31] regBIn,
	output logic [0:31] regBOut,
	
	input logic [0:31]extIn,
	output logic [0:31]extOut
);

logic [0:31] regA;
logic [0:31] regB;
logic [0:31] ext;

always_ff @(posedge clk or posedge rst)
begin 
	if(rst)
		begin 
		regA <= 0;
		regB <= 0;
		ext <= 0;
		end
	else
		begin
		regA <= regAIn;
		regB <= regBIn;
		ext <= extIn;
		end
end

always_ff @(negedge clk)
begin 
	regAOut <= regA;
	regBOut <= regB;
	extOut <= ext;
end

endmodule 