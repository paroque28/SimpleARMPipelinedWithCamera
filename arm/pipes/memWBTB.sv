module memWBTB();
  logic clock;
//Mem WB
logic [31:0] dataMemory;
logic [31:0] resultALU;
logic [3:0]  WAData;
logic [31:0] dataMemoryReg;
logic [31:0] resultALUReg;
logic [3:0]  WADataReg;

pipeMemWB dut(.clk(clock));
