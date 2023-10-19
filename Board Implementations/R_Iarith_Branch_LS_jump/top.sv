module top(reset ,clk,flags,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	input wire reset,clk;
	input wire [3:0] selm;
	output wire [3:0] flags;
	output wire [6:0] hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0;
	
	wire [31:0] PCNext,PC,PCplus4,PCTarget,instr,rd1,rd2,result,alu_src_out,immext,rd2_out,result_out,alu_out,dmem_out,wdmux_out,control;
	wire [3:0] alucontrol;
	wire regwrite,alusrc,branch,BU_out,PCSrc,memwrite,wdsel,jump;
	wire [1:0] immSrc,ResultSrc,aluop;
	
	
	flopr #(31) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCplus4);
	
	imem im(PC,instr);
	
	regfile rf(clk,regwrite,instr[19:15],instr[24:20],instr[11:7],wdmux_out,rd1,rd2);
	
	extend ex(instr[31:7],immSrc,immext);
	
	alu alu1(rd1,alu_src_out,alucontrol,alu_out,flags);
	
	controller controller1(instr[6:0],instr[14:12],instr[30],instr[5],alucontrol,regwrite,alusrc,branch,memwrite,wdsel,jump,immSrc,ResultSrc,aluop);
	
	branchunit branchunit1(flags,instr[14:12],branch,BU_out);
	
	loadstore_unit lsu(instr[14:12],rd2,result,rd2_out,result_out);
	
	dmem dm(clk,memwrite,result,rd2_out,dmem_out);
	
	adder branchadder(PC,immext,PCTarget);
	
	assign control={11'b000_0000_0000,alusrc,aluop,regwrite,branch,immSrc,wdsel,jump,ResultSrc,memwrite,alucontrol,instr[14:12],instr[5],instr[30]};
	
	output_mux out(PCNext,PC,PCplus4,PCTarget,instr,rd1,rd2,result,alu_src_out,immext,rd2_out,result_out,alu_out,dmem_out,wdmux_out,control,
						selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	
	assign alu_src_out = alusrc ? immext : rd2;
	
	assign PCNext = PCSrc ? PCTarget : PCplus4;
	
	assign wdmux_out = wdsel ? result_out : result;
	
	assign result = ResultSrc[1] ? PCplus4 : (ResultSrc[0] ? dmem_out : alu_out);
	
	assign PCSrc = jump | BU_out;
	
endmodule