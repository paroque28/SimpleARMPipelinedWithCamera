module ALU(input logic [2:0] f,input logic [31:0] a,b,  output logic [31:0] y, output logic zero  );

logic [31:0] n1;
assign n1 = a - b;
always_comb 
case (f)
	3'b000: y = a&b;
	3'b001: y = a|b;
	3'b010: y = a+b;
	3'b100: y = a&~b;
	3'b101: y = a|~b;
	3'b110: y = n1;
	3'b111: y = n1[31];
	default: y = 0;
endcase
assign zero = y ? 0:1;
endmodule