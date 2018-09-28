module counter_A(
		input  [8:0] in,
		output logic [3:0] out
		);
		
	logic [7:0] o;
	counter count(
		.in(o),
		.out(out));



	genvar i;
	generate
		 for (i=0; i<7; i=i+1) begin : count_blocks
		 count01 c(
			.in	(in[i+1:i]),
			.out	(o[i]));
		end 
	endgenerate

endmodule

module count01(
		input  [1:0] in,
		output logic  out
		);
always_comb
	case(in)
			2'b10 : out = 1;
			2'bx0 : out = 0;
			2'b11 : out = 0;
			default : out = 0;
	endcase

endmodule
