module insMem (input  logic [31:0] a,
					output logic [31:0] d);
		
	logic [31:0] ROM[63:0];
	
	initial $readmemb("../memory/instructions2.mem",ROM);
		
	assign d = ROM[a[31:2]]; //word alligned
	
endmodule
