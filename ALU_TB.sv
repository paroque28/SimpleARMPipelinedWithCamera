
`timescale 1ns / 1ns
module ALU_TB; 
 
wire  logic  zero; 
wire  [31:0]  y; 
reg  [31:0]  a; 
reg  [31:0]  b; 
reg  [2:0]  f; 
ALU  
 DUT  ( 
       .zero (zero ) ,
      .y (y ) ,
      .a (a ) ,
      .b (b ) ,
      .f (f ) ); 

   reg [2 : 0]  VARf;


// "Counter Pattern"(Range-Up) : step = 1 Range(000-111)
// Start Time = 0 ns, End Time = 400 ns, Period = 50 ns
  initial
  begin
	VARf = 3'b000 ;
	 f  = 3'b000  ;
	repeat(7)
	  begin
	  VARf = VARf  + 1 ;
	  #50  f  = VARf  ;
	  end
	  #50 ;
// 400 ns, repeat pattern in loop.
	#600 ;
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  a  = 32'b00000000000000000000000000010000  ;
	 # 1000 ;
// dumped values till 1 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 us, Period = 0 ns
  initial
  begin
	  b  = 32'b00000000000000000000000000000010  ;
	 # 1000 ;
// dumped values till 1 us
  end

  initial
	#2000 $stop;
endmodule
