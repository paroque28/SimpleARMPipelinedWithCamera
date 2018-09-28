module	VGA_Controller(	//	Host Side
						iRed,
						iGreen,
						iBlue,
						oRequest,
						oX,
						oY,
						//	VGA Side
						oVGA_R,
						oVGA_G,
						oVGA_B,
						oVGA_H_SYNC,
						oVGA_V_SYNC,
						oVGA_BLANK,
						//	Control Signal
						iCLK,
						iRST_N	);

`include "VGA_Param.h"
localparam XBITS = $clog2(H_SYNC_TOTAL);
localparam YBITS = $clog2(V_SYNC_TOTAL);
//	Host Side
input		[7:0]	iRed;
input		[7:0]	iGreen;
input		[7:0]	iBlue;
output	logic			oRequest;
output	logic		[XBITS-1:0]	oX;
output	logic		[YBITS-1:0]	oY;
//	VGA Side
output		[7:0]	oVGA_R;
output		[7:0]	oVGA_G;
output		[7:0]	oVGA_B;
output	logic			oVGA_H_SYNC;
output	logic			oVGA_V_SYNC;
output				oVGA_BLANK;
//	Control Signal
input				iCLK;
input				iRST_N;

//	Internal Registers and Wires
logic		[XBITS-1:0]		H_Cont;
logic		[YBITS-1:0]		V_Cont;

assign	oVGA_BLANK	=	oVGA_H_SYNC & oVGA_V_SYNC;

assign	oVGA_R	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iRed	:	0;
assign	oVGA_G	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iGreen	:	0;
assign	oVGA_B	=	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT &&
						V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )
						?	iBlue	:	0;

assign	 oX 	= 	(	H_Cont>=X_START 	&& H_Cont<X_START+H_SYNC_ACT )	?	H_Cont-X_START	:	0;
assign	 oY 	= 	(	V_Cont>=Y_START 	&& V_Cont<Y_START+V_SYNC_ACT )	?	V_Cont-Y_START	:	0;
//	Pixel LUT Address Generator
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	oRequest	<=	0;
	else
	begin
		if(	H_Cont>=X_START-2 && H_Cont<X_START+H_SYNC_ACT-2 &&
			V_Cont>=Y_START && V_Cont<Y_START+V_SYNC_ACT )
		oRequest	<=	1;
		else
		oRequest	<=	0;
	end
end

//	H_Sync Generator, Ref. 25.175 MHz Clock
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		H_Cont		<=	0;
		oVGA_H_SYNC	<=	0;
	end
	else
	begin
		//	H_Sync Counter
		if( H_Cont < H_SYNC_TOTAL )
		H_Cont	<=	H_Cont+1;
		else
		H_Cont	<=	0;
		//	H_Sync Generator
		if( H_Cont < H_SYNC_CYC )
		oVGA_H_SYNC	<=	0;
		else
		oVGA_H_SYNC	<=	1;
	end
end

//	V_Sync Generator, Ref. H_Sync
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		V_Cont		<=	0;
		oVGA_V_SYNC	<=	0;
	end
	else
	begin
		//	When H_Sync Re-start
		if(H_Cont==0)
		begin
			//	V_Sync Counter
			if( V_Cont < V_SYNC_TOTAL )
			V_Cont	<=	V_Cont+1;
			else
			V_Cont	<=	0;
			//	V_Sync Generator
			if(	V_Cont < V_SYNC_CYC )
			oVGA_V_SYNC	<=	0;
			else
			oVGA_V_SYNC	<=	1;
		end
	end
end

endmodule