module extend (input  logic [23:0] instruction,
					input  logic [1:0]  immSrc,
					output logic [31:0] extImm);
					
	always_comb
		case(immSrc)
						//8-bit unsigned immediate
			2'b00:	extImm = {24'b0, instruction[7:0]};
						//12-bit unsigned immediate
			2'b01:	extImm = {20'b0, instruction[11:0]};
						//24-bit two's complement shifted branch
			2'b10:	extImm = {{6{instruction[23]}},instruction[23:0],2'b00};
						//Indefinido
			default: extImm = 32'bx;
	endcase
endmodule
