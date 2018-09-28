module mux4x1 #(parameter WIDTH = 32)
				   (input  logic  [WIDTH-1:0] a,b,c,d,
					 input  logic	[1:0]			ctrl,
					 output logic  [WIDTH-1:0] y);
		
		assign y = ( ctrl[0] ? (ctrl[1] ? d:b):(ctrl[1] ? c:a) );
		
endmodule
