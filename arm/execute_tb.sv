
module execute_tb();

logic   clk, 
        reset,
        RegWriteE,
        PlusOneIn,
        BranchE,
        PCSrcE,
        ALUSrcE,
        MemToRegE,
        FlagWriteEin,
        ForwardAE,
        ForwardBE,
        MemWriteDin;

logic [31:0] dataRegAIn,
			 dataRegBIn,
			 dataRegCIn,
			 extIn,
			 ResultW,
			 ADataMem;

 logic [3:0]	WA3E,
 				ALUControlE,
				flagsE,
				CondE;

//################ Outputs ##########################
logic [3:0]  	WA3Mout,
				flagsEout;

logic [31:0]    ALUResultE,
			    AToMemout,
				WDToMemout;
                
logic          PCSrcMout,
			   RegWriteMout,
               MemToRegMout,
               BranchTakenE,
               MemWriteEout;

execute StageEXE (
                  .Clk(clk),
                  .reset(reset),
                  .dataRegAIn(dataRegAIn),
				  .dataRegBIn(dataRegBIn),
                  .ALUControlE(ALUControlE),
                  .ForwardAE(ForwardAE),
                  .ForwardBE(ForwardBE),
                  .ALUSrcE(ALUSrcE),
                  //OUTPUTS
                  .ALUResultE(ALUResultE)
);


initial 
begin
ALUResultE = 0;
reset = 0;
#1
reset = 1;
#1
reset = 0;
clk = 0;
dataRegAIn = 32'b101;
dataRegBIn = 32'b10;
ALUControlE = 4'b0001;
ForwardAE = 0;
ForwardBE = 0;
ALUSrcE = 0;
flagsE = 4'b0000;

end

always  #1  clk =  ! clk; 

endmodule