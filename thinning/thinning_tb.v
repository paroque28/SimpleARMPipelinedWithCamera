
`timescale 1ns / 1ns
module thinning_tb   ; 
 
  reg  [31:0]  bottom   ; 
  reg  [31:0]  center   ; 
  wire  [31:0]  result   ; 
  reg  [31:0]  top   ; 
  thinning  
   DUT  ( 
       .bottom (bottom ) ,
      .center (center ) ,
      .result (result ) ,
      .top (top ) ); 



// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 ns, Period = 0 ns
  initial
  begin
		top = 	32'b00000000111011110000000011111111;
		center = 32'b00000000111011110000000011111111;
		bottom = 32'b00000000111011110000000011111111;
		#1
		$display("%B",top);
		$display("%B",center);
		$display("%B",bottom);
		$display("Result: ");
		$display("%B",top);
		$display("%B",result);
		$display("%B",bottom);
		if(result !== 32'b00000000010001100000000001111111 )
			$display("Error");
		#10
		top = 	32'b00110000111011100001110010111111;
		center = 32'b00010100101011110000100011101101;
		bottom = 32'b00110100111011110001110011111101;
		#1
		$display("%B",top);
		$display("%B",center);
		$display("%B",bottom);
		$display("Result: ");
		$display("%B",top);
		$display("%B",result);
		$display("%B",bottom);
		if(result !== 32'b00010100101001100000100011101001 )
			$display("Error");
	
  end


endmodule
