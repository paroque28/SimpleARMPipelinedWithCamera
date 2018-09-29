module mem_controller( input clk,
			input [31:0] address, data_in,
			input we,
			output logic [31:0] data_out);

logic [31:0] a,b,c,d,y;
logic	[1:0]			ctrl;
memSelect(	.address(address),
			.mem_select(ctrl)
);
ram_2port	ram_1 (
	.address_a ( address ),
	.clock_a ( clk ),
	.data_a ( data_in ),
	.wren_a ( we_block[0] ),
	.q_a ( a )
	);
ram_2port	 #(32768,15) ram_2(
	.address_a ( address ),
	.clock_a ( clk ),
	.data_a ( data_in ),
	.wren_a ( we_block[1] ),
	.q_a ( b )
	);

mux4x1  #(32) data_output(.a(a),
				.b(b),
				.c(c),
				.d(d),
				.ctrl(ctrl),
				.y(data_out));
				
logic [3:0] we_block; 

deco we_deco (.sel(ctrl),
		 .in(we),
		 .out(we_block));


endmodule


