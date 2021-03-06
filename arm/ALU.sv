module ALU(input logic [31:0] inputA,
				input logic [31:0] inputB,
				input logic [31:0] inputC,
				input logic [3:0] ALU_control,
				output logic [3:0] ALU_flags,
				output logic [31:0] outputC
);


`include "ALU_params.vh"

logic [32:0] sum;
logic [32:0] sub;
logic [32:0] mult;
logic [32:0] div;
logic [32:0] sl;
logic [32:0] sr;
logic [31:0] and_r;
logic [32:0] average;
logic [32:0] thin;
logic [32:0] result;

logic fneg, fzero, fcarry, foverflow;


assign outputC = result [31:0];
assign  ALU_flags = {fneg, fzero, fcarry, foverflow};
assign sum = inputA + inputB;
assign sub = inputA-inputB;
assign mult = inputA*inputB;
assign div = inputA/inputB;
assign sl = inputA<<inputB;
assign sr = inputA>>inputB;
assign and_r = inputA & inputB;

assign average = (inputA[7:0] + inputA[15:8] + inputA[23:16])/3;

thinning thi (
	.top(inputA),
	.center(inputB),
	.bottom(inputC),
	.result(thin)
);

always_comb
begin
		case(ALU_control)
		
		BUFFER://Case buffer
			result = inputA;
		ADD://Case sum
			result = sum;
		AND://Case AND
			result = {1'b0 , and_r};
		SUB://Case substraction
			result = sub;
		MULT://Case multiply
			result = mult;
		DIV://Case divide
			result = div;
		SL://Case Shift Left
			result = sl;
		SR://Case shift Right
			result = sr;
		AV://Case average
			result = average;
		THI://Case thinning
			result = thin;
		NOP://Case NOP
			result = 0;
			
		default: result = inputA;
		endcase
		
end

//ALUFlags
assign fzero = (result == 0);
assign foverflow = (result[32] == 1'b1);
assign fneg = (ALU_control == ADD || ALU_control == SUB) ? (result[31] == 1'b1) : 1'b0; //FIX
assign fcarry = 1'b0;


endmodule
			