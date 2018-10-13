
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module IMG_PROC(
//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// GPIO_0, GPIO_0 connect to D5M - 5M Pixel Camera //////////
	input 		    [11:0]		D5M_D,
	input 		          		D5M_FVAL,
	input 		          		D5M_LVAL,
	input 		          		D5M_PIXCLK,
	output		          		D5M_RESET_N,
	output		          		D5M_SCLK,
	inout 		          		D5M_SDATA,
	input 		          		D5M_STROBE,
	output		          		D5M_TRIGGER,
	output		          		D5M_XCLKIN,

	//////////// GPIO_1, GPIO_1 connect to MTL - Multi-Touch LCD Panel //////////
	output		     [7:0]		MTL_B,
	output		          		MTL_DCLK,
	output		     [7:0]		MTL_G,
	output		          		MTL_HSD,
	output		     [7:0]		MTL_R,
	output		          		MTL_VSD
);

`include "camera/img_size.vh"

//=======================================================
//  REG/WIRE declarations
//=======================================================

logic write_enable;
logic [31:0] PC, Instr, WriteAddress, WriteData, ReadData;
logic	[1:0]		rClk;
//VGA
logic  reset;
//VGA-Frame
logic [7:0] fr, fg, fb;
logic [11:0] fx ,fy;
logic [PIXELS-1:0] pixel_count_vga;
logic pixel_valid_vga;
//Camera

 logic	[11:0]	mCCD_DATA;
 logic  mCCD_DVAL;					
 logic [11:0] rCCD_DATA;
 logic rCCD_LVAL, rCCD_FVAL;

 logic	[15:0]	X_Cont;
 logic	[15:0]	Y_Cont;
 logic [PIXELS-1:0] pixel_count_camera;
 logic  pixel_valid_camera;
 logic	[31:0]	Frame_Cont;
	
 logic	[11:0]	sCCD_R;
 logic	[11:0]	sCCD_G;
 logic	[11:0]	sCCD_B;
 logic			sCCD_DVAL;


// Delay

logic				DLY_RST_0;
logic				DLY_RST_1;
logic				DLY_RST_2;
//=======================================================
//  Structural coding
//=======================================================
assign MTL_DCLK = ~rClk[0];
assign D5M_XCLKIN = rClk[0];

always@(posedge CLOCK_50)	rClk	<=	rClk+1;

 always_ff @(posedge D5M_PIXCLK)
 begin
 	rCCD_DATA	<=	D5M_D;
 	rCCD_LVAL	<=	D5M_LVAL;
 	rCCD_FVAL	<=	D5M_FVAL;
 end



//=======================================================
// Modules
//=======================================================

//VGA

VGA_Controller vga(	//	Host Side
						.iRed(  (pixel_valid_vga) ?{q_b[23:16], 4'b0000}:0),
						.iGreen((pixel_valid_vga) ?{q_b[15:8] , 4'b0000}:0),
						.iBlue( (pixel_valid_vga) ?{q_b[7:0]  , 4'b0000}:0),
						.oX(fx),
						.oY(fy),
						.oPixel_Cont(pixel_count_vga),
						.oPixel_Valid(pixel_valid_vga),
						//	VGA Side
						.oVGA_R(MTL_R),
						.oVGA_G(MTL_G),
						.oVGA_B(MTL_B),
						.oVGA_H_SYNC(MTL_HSD),
						.oVGA_V_SYNC(MTL_VSD),
						//	Control Signal
						.iCLK(rClk[0]),
						.iRST_N(~rDLY_RST_2)
						);
	
	
//Camera
// assign	D5M_RESET_N	=	DLY_RST_1;
// assign	D5M_TRIGGER	=	1'b1;  // tRIGGER
//  CCD_Capture			ccdc	(	
//  							.oDATA      (mCCD_DATA),
//  							.oDVAL      (mCCD_DVAL),
//  							.oX_Cont    (X_Cont),
//  							.oY_Cont    (Y_Cont),
// 							.oPixel_Cont(pixel_count_camera),
// 							.oPixel_Valid(pixel_valid_camera),
//  							.oFrame_Cont(Frame_Cont),
//  							.iDATA      (rCCD_DATA),
//  							.iFVAL      (rCCD_FVAL),
//  							.iLVAL      (rCCD_LVAL),
//  							.iSTART     (!KEY[3]),
//  							.iEND       (!KEY[2]),
//  							.iCLK       (D5M_PIXCLK),
//  							.iRST       (DLY_RST_2)
//  						);

//  RAW2RGB				raw2rgb	(	
//  						   .iCLK   (D5M_PIXCLK),
//  							.iRST   (DLY_RST_1),
//  							.iDATA  (mCCD_DATA),
//  							.iDVAL  (mCCD_DVAL),
//  							.oRed   (sCCD_R),
//  							.oGreen (sCCD_G),
//  							.oBlue  (sCCD_B),
//  							.oDVAL  (sCCD_DVAL),
//  							.iX_Cont(X_Cont),
//  							.iY_Cont(Y_Cont)
//  						);
						
 Reset_Delay			reset_delay	(	
 							.iCLK  (CLOCK_50),
 							.iRST  (KEY[0]),
 							.oRST_0(DLY_RST_0),
 							.oRST_1(DLY_RST_1),
 							.oRST_2(DLY_RST_2)
 						);
						
// I2c Camera

// I2C_CCD_Config 		u8	(	//	Host Side
// 								 .iCLK			  (CLOCK_50),
// 								 .iRST_N         (DLY_RST_2),
// 								 .iZOOM_MODE_SW  (SW[8]),
// 								 .iEXPOSURE_ADJ  (KEY[1]),
// 								 .iEXPOSURE_DEC_p(SW[0]),
// 								  //	I2C Side
// 								 .I2C_SCLK		  (D5M_SCLK),
// 								 .I2C_SDAT		  (D5M_SDATA)
// 							   );
								
//RAM

logic [15:0] address_a, address_b;
logic [31:0] q_a, q_b, data_a, data_b;
logic clock_a, clock_b, wren_a, wren_b;
// assign address_a = pixel_count_camera;
assign clock_a = rClk[0];
// assign data_a = {4'b00000000, sCCD_R[11:4], sCCD_G[7:0], sCCD_B[11:4]} ;
assign address_b = (pixel_valid_vga) ? pixel_count_vga : 0;
assign clock_b = rClk[0];
// assign wren_a = pixel_valid_camera;
assign wren_b = 1'b0;

mem_controller mem (    .clk(CLOCK_50),
                        .address(WriteAddress),  .address_b(address_b),
						.data_in(WriteData),	 .data_in_b(data_b),
                        .we(write_enable),		 .we_b(wren_b),
                        .data_out(ReadData), 	 .data_out_b(q_b));


// assign LEDR[8:0] = rCCD_DATA;
// assign LEDR[9] = D5M_PIXCLK;


endmodule
