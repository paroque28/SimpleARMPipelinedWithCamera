module registerFile (input  logic 		 clk,
						   input  logic		    we,
						   input  logic [3:0]  a1, a2, a3, wa,
						   input  logic [31:0] wd, r15,
						   output logic [31:0] rd1, rd2, rd3);
						  
	logic [31:0] rf[14:0];
	
	always_ff @(posedge clk)
		if (we) rf[wa] <= wd;
		
	assign rd1 = (a1==4'b1111) ? r15:rf[a1];
	assign rd2 = (a2==4'b1111) ? r15:rf[a2];
	assign rd3 = (a3==4'b1111) ? r15:rf[a3];
	
endmodule
