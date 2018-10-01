`timescale 1ps / 1ps

module memSelect_tb  ; 

parameter limitA = 'h40000;
parameter limitB = 'h60000;
parameter limitC = 'h60004;
parameter limitD = 'h80000;
  logic  [3:0]  mem_select   ; 
  logic  [31:0]  address   ; 
  memSelect    #( limitA , limitB , limitC , limitD  )
   DUT  ( 
       .mem_select (mem_select ) ,
      .address (address) ); 



  initial
  begin
	  address  = 'h00000  ;
		#1;
		address  = 'h00010  ;
		#1;
		address  = 'h10000  ;
		#1;
		address  = 'h20000  ;
		#1;
		address  = 'h30000  ;
		#1;
		address  = 'h40000  ;
		#1;
		address  = 'h50000  ;
		#1;
		address  = 'h70000  ;
		#1;
		address  = 'h80000  ;
		#1;
		address  = 'h90000  ;
		#1;
  end
endmodule
