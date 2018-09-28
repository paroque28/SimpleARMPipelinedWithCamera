module framebuffer
#(parameter WIDTH = 800,HEIGHT = 480)
	(input reset_n,
	 input vga_clk,

	 input [XBITS-1:0] fb_xpos,
	 input [YBITS-1:0] fb_ypos,
	 
	 output reg [7:0] red,
	 output reg [7:0] green,
	 output reg [7:0] blue
	);
`include "VGA_Param.h"
localparam XBITS = $clog2(H_SYNC_TOTAL);
localparam YBITS = $clog2(V_SYNC_TOTAL);
	always @(posedge vga_clk or negedge reset_n) begin
		if(~reset_n) begin
			red <= 8'b0000_0000;
			green <= 8'b0000_0000;
			blue <= 8'b0000_0000;
		end else begin
				red <= fb_xpos[9:2];
				green <= 8'b0000_0000;

				blue <= fb_ypos[8:1];
	
		end
	end

	
endmodule