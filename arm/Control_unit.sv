
module Control_unit (input logic [5:0] funct,
							input logic [1:0]opcode,
							output logic ALUSrcE,
							output logic [3:0] ALUControlE,
							output logic MemToRegD,
							output logic [1:0] RegSrcD, // No va al pipe
							output logic [1:0]ImmSrcD, // No va al pipe
							output logic RegWriteD,
							output logic PlusOne,
							output logic BranchD,
							output logic PCSrcD,
							output logic [1:0] FlagW,
							output logic MemWriteD
							);


`include "ALU_params.vh"
`include "Control_params.vh"

logic [3:0] cmd;
logic IFlag, SFlag, PlusOneMem, UpDownMem, ByteWordMem, WBMem, LdStMem;
//logic ALUOp;
//Data Flags
assign cmd = funct [4:1];
assign IFlag = funct[5]; //Immediate Flag
assign SFlag = funct[0]; //Set Fflags flag
//Memory flags
assign PlusOneMem       = funct[4]; // Plus One  Flag 0: No 1: Add 1
assign UpDownMem        = funct[3]; // Up Down Flag  0: down 1: up
assign ByteWordMem      = funct[2]; // Byte WOrd Flag 0: word 1: byte  // NOT IMPLEMENTED
assign WBMem            = funct[1]; // Write back Flag 0: no  1: write address //NOT IMPLEMENTED
assign LdStMem          = funct[0]; // Load / Store Flag  0: Store 1: Load

assign PlusOne = (PlusOneMem && opcode == OPMEMORY);
assign ALUSrcE = funct[5];
assign MemToRegD =   (opcode == OPMEMORY &&  LdStMem);
assign RegWriteD = ~((opcode == OPMEMORY && ~LdStMem) || cmd == FPIC || ( opcode == OPDATA && cmd == FNOP) || opcode == OPBRANCH);
assign ImmSrcD[0] = (opcode == OPMEMORY);
assign ImmSrcD[1] = (opcode == OPBRANCH);

assign BranchD = (opcode == OPBRANCH);
//assign ALUOp = (opcode == OPDATA);
assign RegSrcD[0] = (opcode == OPBRANCH);
assign RegSrcD[1] = (opcode == OPMEMORY && ~LdStMem);
assign PCSrcD = (opcode == OPBRANCH);

assign FlagW[1] = SFlag;
assign FlagW[0] = SFlag & (ALUControlE == ADD | ALUControlE == SUB);

assign MemWriteD = ~SFlag & opcode == OPMEMORY;

always_comb
begin
	case (opcode)
		OPDATA:begin
			case(cmd)
				FNOP: begin //Case AND
						ALUControlE =	NOP;
				end
				FADD: begin //Case ADD
						ALUControlE =	ADD;
				end
				FSUB: begin //Case SUBS
						ALUControlE =	SUB;
				end
				FMULT: begin //Case MULT
						ALUControlE =	MULT;
				end
				FAVERAGE: begin//Case Ponderate RGB
						ALUControlE =	AV;
				end
				default:
				begin
						ALUControlE =	4'bz;
						end
			endcase
		end
		OPMEMORY: case (UpDownMem)
						1'b0: ALUControlE = ADD;
						1'b1: ALUControlE = SUB;
						default: ALUControlE = ADD;
		endcase
		OPBRANCH: ALUControlE = ADD;
		default:
		begin
				ALUControlE =	4'bz;
		end
	endcase
	
end


endmodule
