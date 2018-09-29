module cond_unit(input [3:0]flagsE_in,
						input [3:0] ALU_flags,
						input [3:0] condE,
						input FlagWriteE,
						output condExE,
						output flagsE_out
						);

assign flagsE_out = ALU_flags;
//assign condExE =  (condE == flagsE_in);



parameter cond_greater  	= 4'b0000;
parameter cond_equal    	= 4'b0001;
parameter cond_less     	= 4'b0010;
parameter cond_notequal 	= 4'b0011;

//NZCV
/*
parameter less_than     	= 4'b1000;
parameter equal_to      	= 4'b0100;
parameter greater_than  	= 4'b0000;

parameter activate_conds   = 1'b1;
parameter deactivate_conds = 1'b0;
*/




always_comb
begin
	case(condE)
	
	cond_greater:
		condExE = (ALU_flags[3:2] == 2'b00);
	cond_equal:
		condExE = (ALU_flags[2] == 1);
	cond_less:
		condExE = (ALU_flags[3] == 1);
	cond_notequal:
		condExE = (ALU_flags[2] == 0);
	default: condExE = 1'b1;
	
	endcase
end

endmodule
