module controller(input wire [6:0] opcode,
						input wire [14:12] funct3,
						input wire funct75,op5,
						output wire [3:0] alucontrol,
						output wire alusrc,regwrite);
						
	wire [1:0] aluop;

	aludec aludec1(aluop,funct3,funct75,op5,alucontrol);
	maindec maindec1(opcode,alusrc,regwrite,aluop);
endmodule
