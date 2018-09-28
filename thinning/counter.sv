module counter(
		input  [7:0] in,
		output logic [3:0] out
		);
logic [2:0] a, b;
count_bits count1(
		.in(in[7:4]),
		.out(a)
		);
count_bits count2(
		.in(in[3:0]),
		.out(b)
		);
assign out = a + b;

endmodule


module count_bits(
		input  [3:0] in,
		output logic [2:0] out
		);
always_comb begin
	case(in)
		4'b0000 : out = 0;
		4'b0001 : out = 1;
		4'b0010 : out = 1;
		4'b0100 : out = 1;
		4'b1000 : out = 1;
		4'b0011 : out = 2;
		4'b0101 : out = 2;
		4'b1001 : out = 2;
		4'b0110 : out = 2;
		4'b1010 : out = 2;
		4'b1100 : out = 2;
		4'b0111 : out = 3;
		4'b1011 : out = 3;
		4'b1101 : out = 3;
		4'b1110 : out = 3;
		4'b1111 : out = 4;
		default : out = 0;
	endcase
end

endmodule