module mux2x1 #(parameter WIDTH = 32)
				   (input  logic  [WIDTH-1:0] a,b,
					 input  logic				  ctrl,
					 output logic  [WIDTH-1:0] y);
		
		assign y = ctrl ? b:a;
		
endmodule
