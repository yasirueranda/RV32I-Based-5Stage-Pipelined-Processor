module top(reset ,clk,flags,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	input wire reset,clk;
	input wire [2:0] selm;
	output wire [3:0] flags;
	output wire [6:0] hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0;
	
	wire [31:0] PCNext,PC,PCplus4,PCTarget,instr,rd1,rd2,result,alu_src_out,immext;
	wire [3:0] alucontrol;
	wire regwrite,alusrc,branch,PCSrc,immSrc;
	
	
	flopr #(31) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCplus4);
	
	imem im(PC,instr);
	
	regfile rf(clk,regwrite,instr[19:15],instr[24:20],instr[11:7],result,rd1,rd2);
	
	extend ex(instr[31:7],immSrc,immext);
	
	alu alu1(rd1,alu_src_out,alucontrol,result,flags);
	
	controller controller1(instr[6:0],instr[14:12],instr[30],alucontrol,regwrite,alusrc,branch,immSrc);
	
	branchunit branchunit1(flags,instr[14:12],branch,PCSrc);
	
	adder branchadder(PC,immext,PCTarget);
	
	output_mux out(rd1,rd2,result,instr,alu_src_out,immext,pctarget,pcnext,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	
	assign alu_src_out = alusrc ? immext : rd2;
	
	assign PCNext = PCSrc ? PCTarget : PCplus4;
	
endmodule