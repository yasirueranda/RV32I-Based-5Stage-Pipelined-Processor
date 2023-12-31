module hazard_unit(input wire [4:0] rs1_addr_ex,rs2_addr_ex,regwrite_addr_EX,
						 input wire ResultSrc_EX_0,
						 output wire stallD,stallF,flushE);
		wire lwstallD;
		assign lwstallD=ResultSrc_EX_0 & ((rs1_addr_ex==regwrite_addr_EX)|(rs2_addr_ex==regwrite_addr_EX));
		assign stallD=lwstallD;
		assign stallF=lwstallD;
		assign flushE=lwstallD;	
endmodule