module ALU(input logic [31:0] inputA,
				input logic [31:0] inputB,
				input logic [31:0] inputC,
				input logic [3:0] ALU_control,
				output logic [3:0] ALU_flags,
				output logic [31:0] outputC
);

logic [31:0] buffer;
logic [31:0] SUM;
logic [31:0] SUB;
logic [31:0] Mult;
logic [31:0] DIV;
logic [31:0] SL;
logic [31:0] SR;
logic [31:0] AVERAGE;
logic [31:0] THIN;

assign buffer = inputA;
assign SUM = inputA + inputB;
assign SUB = inputA-inputB;
assign Mult = inputA*inputB;
assign DIV = inputA/inputB;
assign SL = inputA<<inputB;
assign SR = inputA>>inputB;
assign AVERAGE = (inputA[7:0] + inputA[15:8] + inputA[23:16])/3;
thinning thi (
	.top(inputA),
	.center(inputB),
	.bottom(inputC),
	.result(THIN)
);

always_comb
begin
		case(ALU_control)
		
		4'b0000://Case buffer
			outputC = buffer;
		4'b0001://Case sum
			outputC = SUM;
		4'b0010://Case substraction
			outputC = SUB;
		4'b0011://Case multiply
			outputC = Mult;
		4'b0100://Case divide
			outputC = DIV;
		4'b0101://Case Shift Left
			outputC = SL;
		4'b0110://Case shift Right
			outputC = SR;
		4'b0111://Case average
			outputC = AVERAGE;
		4'b1000://Case thinning
			outputC = THIN;
			
		default: outputC = buffer;
		endcase
		
end
always_comb //Falta agregar overflow
begin
	if (outputC == 0)
		begin
		ALU_flags = 4'b0100;
		end
	else
		begin
			if (outputC[31] == 1'b1)
				begin
					if (ALU_control == 4'b0010)
						begin
						ALU_flags = 4'b1000;
						end
					else
						begin
						ALU_flags = 4'b0010;
						end
				end
			else
				begin
				ALU_flags = 4'b0000;
				end
		end
end
endmodule
			