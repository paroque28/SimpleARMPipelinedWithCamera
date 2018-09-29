module deco(   input [1:0] sel,
		        input in ,
		        output logic [3:0] out);

assign out [0] = (in && (sel == 2'b00));
assign out [1] = (in && (sel == 2'b01));
assign out [2] = (in && (sel == 2'b10));
assign out [3] = (in && (sel == 2'b11));

endmodule
