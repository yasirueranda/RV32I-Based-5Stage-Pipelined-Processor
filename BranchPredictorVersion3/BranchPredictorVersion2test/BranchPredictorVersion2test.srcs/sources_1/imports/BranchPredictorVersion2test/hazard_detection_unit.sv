module hazard_detection_unit(input wire [4:0] rs1_addr_ID,rs2_addr_ID,regwrite_addr_EX,
						 input wire ResultSrc_EX_0,
						 output wire stallD,stallF,flushE);
		wire lwstallD;
		assign lwstallD=ResultSrc_EX_0 & ((rs1_addr_ID==regwrite_addr_EX)|(rs2_addr_ID==regwrite_addr_EX));
		assign stallD=lwstallD;
		assign stallF=lwstallD;
		assign flushE=lwstallD;	
endmodule