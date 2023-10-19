module top(reset,clk,flags,PCNext_o,PC_o,PCplus4_o,PCTarget_o,instr_o,rd1_o,rd2_o,result_o,alu_src_out_o,immext_o);
	input wire reset,clk;
	output wire [3:0] flags;
	output wire [31:0] PCNext_o,PC_o,PCplus4_o,PCTarget_o,instr_o,rd1_o,rd2_o,result_o,alu_src_out_o,immext_o;
	
	wire [31:0] PCNext,PC,PCplus4,PCTarget,instr,rd1,rd2,result,alu_src_out,immext;
	wire [3:0] alucontrol;
	wire regwrite,alusrc,branch,PCSrc,immSrc;
	
	
	flopr #(32) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCplus4);
	
	imem im(PC,instr);
	
	regfile rf(clk,reset,regwrite,instr[19:15],instr[24:20],instr[11:7],result,rd1,rd2);
	
	extend ex(instr[31:7],immSrc,immext);
	
	alu alu1(rd1,alu_src_out,alucontrol,result,flags);
	
	controller controller1(instr[6:0],instr[14:12],instr[30],alucontrol,regwrite,alusrc,branch,immSrc);
	
	branchunit branchunit1(flags,instr[14:12],branch,PCSrc);
	
	adder branchadder(PC,immext,PCTarget);
	
	
	assign alu_src_out = alusrc ? immext : rd2;
	
	assign PCNext = PCSrc ? PCTarget : PCplus4;
	
	assign PCNext_o=PCNext;
	assign PC_o=PC;
	assign PCplus4_o=PCplus4;
	assign PCTarget_o=PCTarget;
	assign instr_o=instr;
	assign rd1_o=rd1;
	assign rd2_o=rd2;
	assign result_o=result;
	assign alu_src_out_o=alu_src_out;
	assign immext_o=immext;
	
endmodule