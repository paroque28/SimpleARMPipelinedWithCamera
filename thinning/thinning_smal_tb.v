
`timescale 1ns / 1ns
module thinning_smal_tb  ; 
 
  reg  [2:0]  bottom   ; 
  reg  [2:0]  center   ; 
  wire   result   ; 
  reg  [2:0]  top   ; 
  thinning_small  
   DUT  ( 
       .bottom (bottom ) ,
      .center (center ) ,
      .result (result ) ,
      .top (top ) ); 



// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 ns, Period = 0 ns
initial
begin
top	 = 3'b 111;
center = 3'b 011;
bottom = 3'b 011;

#20

// $display(A);
// $display(B);
// $display(vecinos);
// $display(vecinos_cadena);
// $display(P2P4P6white);
// $display(P4P6P8white);
// $display(P2P4P8white);
// $display(P2P6P8white);
// $display(step1);
// $display(step2);
$display(result);

end


endmodule
