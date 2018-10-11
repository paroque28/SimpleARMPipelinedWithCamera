
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
        MemWriteDin;

logic [1:0] ForwardAE,
            ForwardBE;

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
                  .extIn(extIn),
                  //OUTPUTS
                  .ALUResultE(ALUResultE),
                  .AToMemout(AToMemout)
);


initial 
begin
//ALUResultE = 0;
reset = 0;
#2
reset = 1;
#2
reset = 0;
#2
extIn = 32'b1;
clk = 0;
dataRegAIn = 32'b101;
dataRegBIn = 32'b10;
ALUControlE = 4'b0001;
ForwardAE = 2'b00;
ForwardBE = 2'b00;
ALUSrcE = 0;
//flagsE = 4'b0000;
#10
ForwardAE = 2'b00;
ForwardBE = 2'b00;
#10
ForwardAE = 2'b01;
ForwardBE = 2'b01;
#10
ForwardAE = 2'b10;
ForwardBE = 2'b10;



$display("ALU is not working");
$display(ADataMem);
end

always  #1  clk =  ! clk; 

endmodule