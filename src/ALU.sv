module ALU(input logic [31:0] inputA,inputB,
				input logic [3:0] ALU_control,
				output logic [3:0] ALU_flags,
				output logic [31:0] outputC
);

logic [32:0] temp_result;
logic [3:0] temp_flags;

always_comb
		case(ALU_control)
		4'b0000://Case buffer
			temp_result = inputA;
		4'b0001://Case sum
			temp_result = inputA + inputB;
		4'b0010://Case substraction
			temp_result = inputA - inputB;
		4'b0011://Case multiply
			temp_result = inputA * inputB;
		4'b0100://Case divide
			temp_result = inputA/inputB;
		4'b0101://Case Shift Left
			temp_result = inputA<<inputB;
		4'b0110://Case shift Right
			temp_result = inputA>>inputB;
		4'b0111://Case special sum
			temp_result = inputA[7:0] + inputA[15:8] + inputA[23:16];
			
		default: temp_result = 0;
		endcase

always_comb //Falta agregar overflow
	if (temp_result == 0)
		begin
		temp_flags = 4'b0100;
		end
	else
		begin
			if (temp_result[32] == 1'b1)
				begin
					if (ALU_control == 4'b0010)
						begin
						temp_flags = 4'b1000;
						end
					else
						begin
						temp_flags = 4'b0010;
						end
				end
			else
				begin
				temp_flags = 4'b0000;
				end
		end

		
assign outputC = temp_result;
assign ALU_flags = temp_flags;

endmodule
			