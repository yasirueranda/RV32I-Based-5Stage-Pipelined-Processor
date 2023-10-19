module cpu(reset ,clk,flags,pcnext_o,pc_o,pcplus4_o,pctarget_o,instr_o,rd1_o,rd2_o,result_o,alu_src_out_o,immext_o,rd2_out_o,result_out_o,alu_out_o,dmem_out1_o,dmem_out2_o,wdmux_out_o,control_o,array_out_o);
	input wire reset,clk;
	output wire [3:0] flags;
	output wire [31:0] pcnext_o,pc_o,pcplus4_o,pctarget_o,instr_o,rd1_o,rd2_o,result_o,alu_src_out_o,immext_o,rd2_out_o,result_out_o,alu_out_o,dmem_out1_o,dmem_out2_o,wdmux_out_o,control_o,array_out_o;
	
	wire [31:0] PCNext,PC,PCplus4,PCTarget,instr,rd1,rd2,result,alu_src_out,immext,rd2_out,result_out,alu_out,dmem_out1,dmem_out2,wdmux_out,control,jumpmux_out,array_out;
	wire [3:0] alucontrol;
	wire regwrite,alusrc,branch,BU_out,PCSrc,memwrite1,memwrite2,jump,jumpsel;
	wire [1:0] ResultSrc,aluop,wdsel;
	wire [2:0] immSrc;
	
	
	flopr #(32) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCplus4);
	
	imem im(PC,instr);
	
	regfile rf(clk,reset,regwrite,instr[19:15],instr[24:20],instr[11:7],wdmux_out,rd1,rd2);
	
	extend ex(instr[31:7],immSrc,immext);
	
	alu alu1(rd1,alu_src_out,alucontrol,alu_out,flags);
	
	controller controller1(instr[6:0],instr[14:12],instr[30],instr[5],alucontrol,regwrite,alusrc,branch,memwrite1,memwrite2,wdsel,jump,jumpsel,immSrc,ResultSrc,aluop);
	
	branchunit branchunit1(flags,instr[14:12],branch,BU_out);
	
	loadstore_unit lsu(instr[14:12],rd2,result,rd2_out,result_out);
	
	dmem dm(clk,reset,memwrite1,memwrite2,alu_out,rd2,rd2_out,array_out,dmem_out1,dmem_out2);
	
	arrayunit unit1(instr[14:12],dmem_out1,dmem_out2,array_out);
	
	adder branchadder(jumpmux_out,immext,PCTarget);
	
	assign control={instr[6:2],jumpsel,BU_out,PCSrc,alusrc,aluop,regwrite,branch,immSrc,wdsel,jump,ResultSrc,memwrite1,memwrite2,alucontrol,instr[14:12],instr[5],instr[30]};
	
	assign alu_src_out = alusrc ? immext : rd2;
	
	assign PCNext = PCSrc ? PCTarget : PCplus4;
	
	assign wdmux_out = wdsel[0] ? (wdsel[1] ? PCTarget : result_out) : (wdsel[1] ? immext : result);
	
	assign jumpmux_out = jumpsel ? rd1 : PC;
	
	assign result = ResultSrc[1] ? PCplus4 : (ResultSrc[0] ? dmem_out1 : alu_out);
	
	assign PCSrc = jump | BU_out;
	
	assign pcnext_o=PCNext;
	assign pc_o=PC;
	assign pcplus4_o=PCplus4;
	assign pctarget_o=PCTarget;
	assign instr_o=instr;
	assign rd1_o=rd1;
	assign rd2_o=rd2;
	assign result_o=result;
	assign alu_src_out_o=alu_src_out;
	assign immext_o=immext;
	assign rd2_out_o=rd2_out;
	assign result_out_o=result_out;
	assign alu_out_o=alu_out;
	assign dmem_out1_o=dmem_out1;
	assign dmem_out2_o=dmem_out2;
	assign wdmux_out_o=wdmux_out;
	assign control_o=control;
	assign array_out_o=array_out;
	
endmodule