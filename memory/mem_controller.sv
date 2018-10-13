module mem_controller( input clk,
			input [31:0] address, data_in, address_b , data_in_b,
			input we, we_b,
			output logic [31:0] data_out, data_out_b);

logic [31:0] a,b;
logic	[1:0]			memSel;
logic	[3:0]			write_enable;
logic [31:0] flags[3:0];

memSelect memsel(	.address(address),
			.mem_select(memSel)
);

ram	ram_1 (
	.address_a ( address ),
	.address_b ( address_b ),
	.clock_a ( clk ),
	.clock_b ( clk ),
	.data_a ( data_in ),
	.data_b ( data_in_b ),
	.wren_a ( write_enable[0] && we ),
	.wren_b ( we_b ),
	.q_a ( a ),
	.q_b ( data_out_b )
	);

always_comb begin
	case(memSel)
		2'b00: begin
			write_enable = 4'b0001;
			data_out = a;
		end
		2'b01: begin
			write_enable = 4'b0010;
			if(we) begin 
				data_out = data_in;
				flags[address[1:0]] = data_in;
			end else data_out = flags[address[1:0]];
		end
		2'b10: begin
			write_enable = 4'b0100;
			data_out = 32'bz;
		end
		2'b11: begin
			write_enable = 4'b1000;
			data_out = 32'bz;
		end
		default: begin
			write_enable = 4'bz;
			data_out = 32'bz;
		end
	endcase
end	


endmodule


