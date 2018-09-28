module adder #(parameter WIDTH = 8)
				  (input  logic [WIDTH-1:0] a,b,
				   output logic [WIDTH-1:0] c);

	assign c = a + b;
endmodule
