module controller(input wire [6:0] opcode,
						input wire [14:12] funct3,
						input wire funct75,
						input wire op5,
						output wire [3:0] alucontrol,
						output wire regwrite,alusrc,branch,memwrite1,memwrite2,
						output wire [1:0] wdsel,
						output wire jump,jumpsel,
						output wire [2:0] immsrc,
						output wire [1:0] resultsrc,
						output wire [1:0] aluop_wire_out);
						
	wire [1:0] aluop;

	aludec aludec1(aluop,funct3,funct75,op5,alucontrol);
	maindec maindec1(opcode,regwrite,alusrc,branch,immsrc,aluop,memwrite1,memwrite2,wdsel,jump,jumpsel,resultsrc);
	
	assign aluop_wire_out=aluop;
	
endmodule
