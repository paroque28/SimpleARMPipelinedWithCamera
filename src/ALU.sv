module ALU(input logic [31:0] inputA,
				input logic [31:0] inputB,
				input logic [31:0] inputC,
				input logic [3:0] ALU_control,
				output logic [3:0] ALU_flags,
				output logic [31:0] outputC
);

logic [32:0] sum;
logic [32:0] sub;
logic [32:0] mult;
logic [32:0] div;
logic [32:0] sl;
logic [32:0] sr;
logic [32:0] average;
logic [32:0] thin;
logic [32:0] result;
logic neg, zero, carry, overflow, ge;


parameter BUFFER = 4'b0000;
parameter ADD	 = 4'b0001;
parameter SUB   = 4'b0010;
parameter MULT   = 4'b0011;
parameter DIV	 = 4'b0100;
parameter SL     = 4'b0101;
parameter SR     = 4'b0110;
parameter AV     = 4'b0111;
parameter THI    = 4'b1000

assign outputC = result [31:0];
assign {neg, zero, carry, overflow} = ALUFlags;
assign sum = inputA + inputB;
assign sub = inputA-inputB;
assign mult = inputA*inputB;
assign div = inputA/inputB;
assign sl = inputA<<inputB;
assign sr = inputA>>inputB;
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
			
		default: result = buffer;
		endcase
		
end

//ALUFlags
assign zero = (result == 0);
assign overflow = (result[32] == 1'b1);
assign neg = (ALU_control == ADD || ALU_control == SUB) ? (result[31] == 1'b1) : 1'b0; //FIX
assign overflow = 1'b0;// FIX
assign ge = 1'b0;// FIX
endmodule
			