module mux3x1 #(parameter WIDTH = 32)
				   (input  logic  [WIDTH-1:0] a,b,c,
					 input  logic	[1:0]			ctrl,
					 output logic  [WIDTH-1:0] y);
		
		assign y = ( ctrl[0] ? (ctrl[1] ? 32'bz:b):(ctrl[1] ? c:a) );
		
endmodule
