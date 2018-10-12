module cond_unit(   input logic clk, reset,
                    input [3:0] flagsE_in,
                    input [3:0] ALU_flags,
                    input [3:0] condE,
                    input [1:0] FlagWriteE,
                    output logic    condEx,
                    output [3:0] flagsE_out
                    );
                        
    logic [1:0] FlagWrite;
    logic [3:0] Flags;
    assign FlagWrite = FlagWriteE & {2{condEx}};
    assign flagsE_out = Flags;
    flopenr #(2)flagreg1(clk, reset, FlagWrite[1],
                        ALU_flags[3:2], Flags[3:2]);
    flopenr #(2)flagreg0(clk, reset, FlagWrite[0],
                        ALU_flags[1:0], Flags[1:0]);

    condcheck cc(condE, Flags, condEx);

endmodule

module condcheck(input logic [3:0] Cond,
                    input logic [3:0] Flags,
                    output logic CondEx);
                    
    logic neg, zero, carry, overflow, ge;
    
    assign {neg, zero, carry, overflow} = Flags;
    assign ge = (neg == overflow); 
    
    always_comb
    case(Cond)
        4'b0000: CondEx = zero; // EQ
        4'b0001: CondEx = ~zero; // NE
        4'b0010: CondEx = carry; // CS
        4'b0011: CondEx = ~carry; // CC
        4'b0100: CondEx = neg; // MI
        4'b0101: CondEx = ~neg; // PL
        4'b0110: CondEx = overflow; // VS
        4'b0111: CondEx = ~overflow; // VC
        4'b1000: CondEx = carry & ~zero; // HI
        4'b1001: CondEx = ~(carry & ~zero); // LS
        4'b1010: CondEx = ge; // GE
        4'b1011: CondEx = ~ge; // LT
        4'b1100: CondEx = ~zero & ge; // GT
        4'b1101: CondEx = ~(~zero & ge); // LE
        4'b1110: CondEx = 1'b1; // Always
        4'b1111: CondEx = 1'b0; // Never
        default: CondEx = 1'bx; // undefined
    endcase
endmodule

module flopenr #(parameter WIDTH = 8)
        (input logic clk, reset, en,
        input logic [WIDTH-1:0] d,
        output logic [WIDTH-1:0] q);
        
    always_ff @(posedge clk, posedge reset)
        if (reset) q <= 0;
        else if (en) q <= d;
endmodule
