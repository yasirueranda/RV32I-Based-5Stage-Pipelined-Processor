module top(reset ,clk,flags_EX,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	input wire reset,clk;
	input wire [5:0] selm;
	output wire [3:0] flags_EX;
	output wire [6:0] hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0;
	
	wire [31:0] control_ID_1,control_ID_2,control_EX,control_MEM,control_WB,forward_control,Target_PC,PCplus4,PCNext;
	wire [1:0] control_1,control_2;
	wire stallD,stallF,flushE,prediction,flush_branch;
	
	/***********************************************************/
	
	//IF stage
	wire [31:0] PC_IF,PCplus4_IF,instr_IF;
	//ID stage
	wire [31:0] instr_ID,immext_ID,rd1_ID,rd2_ID,PC_ID,PCplus4_ID,PCTarget_ID;
	wire [3:0] alucontrol_ID;
	wire regwrite_ID,alusrc_ID,memwrite_ID,jumpsel_ID,branch_ID;
	wire [2:0] immSrc;
	wire [1:0] wdsel_ID,ResultSrc_ID,aluop_wire_out_ID;
	//EX stage
	wire [31:0] rd1_EX,rd2_EX,immext_EX,alu_out_EX,alu_src_out,jumpmux_out,PCplus4_EX,operand_1_EX,operand_2_EX,instr_EX,PCTarget_EX;
	wire [4:0] regwrite_addr_EX,rs1_addr_EX,rs2_addr_EX;
	wire [3:0] alucontrol_EX;
	wire [2:0] funct3_EX;
	wire alusrc_EX,memwrite_EX,jumpsel_EX,regwrite_EX,branch_EX,PCSrc_EX;
	wire [1:0] wdsel_EX,ResultSrc_EX;
	//MEM stage
	wire [31:0] alu_out_MEM,rd2_out_MEM,dmem_out_MEM,operand_2_MEM,immext_MEM,PCTarget_MEM,PCplus4_MEM,instr_MEM;
	wire [4:0] regwrite_addr_MEM;
	wire [2:0] funct3_MEM;
	wire memwrite_MEM,regwrite_MEM;
	wire [1:0] wdsel_MEM,ResultSrc_MEM;
	//WB stage
	wire [31:0] alu_out_WB,dmem_out_WB,result_WB,wdmux_out_WB,result_out_WB,immext_WB,PCTarget_WB,PCplus4_WB,instr_WB;
	wire [4:0] regwrite_addr_WB;
	wire [2:0] funct3_WB;
	wire [1:0] wdsel_WB,ResultSrc_WB;
	wire regwrite_WB;
	wire branch_prediction,delayed_branch_prediction2,predictionOut;
	
	/******************************************************************/
	
	assign PCNext = predictionOut ? Target_PC : PCplus4;
	
	//IF stage
	flopenr #(32) pcreg(clk,reset,~stallF,PCNext,PC_IF);
	adder pcadder(PC_IF,32'h00000004,PCplus4_IF);
	imem im(PC_IF,instr_IF);
	
	//ID stage
	flopenr #(96) IF_ID_1(clk,reset,~stallD,{instr_IF,PC_IF,PCplus4_IF},
														 {instr_ID,PC_ID,PCplus4_ID});
	//flopenr #(32) IF_ID_2(clk,reset,~stallD,PC_IF,PC_ID);
	//flopenr #(32) IF_ID_3(clk,reset,~stallD,PCplus4_IF,PCplus4_ID);
	controller controller1(instr_ID[6:0],instr_ID[14:12],instr_ID[30],instr_ID[5],alucontrol_ID,regwrite_ID,alusrc_ID,memwrite_ID,wdsel_ID,immSrc,ResultSrc_ID,jumpsel_ID,aluop_wire_out_ID,branch_ID);
	regfile rf(clk,regwrite_WB,instr_ID[19:15],instr_ID[24:20],regwrite_addr_WB,wdmux_out_WB,rd1_ID,rd2_ID);
	extend ex(instr_ID[31:7],immSrc,immext_ID);
	
	assign jumpmux_out = jumpsel_ID ? rd1_ID : PC_ID;
	adder branchadder(jumpmux_out,immext_ID,PCTarget_ID);
	
	//EX stage
	floprc #(222) ID_EX_1(clk,reset,flushE,{rd1_ID,rd2_ID,immext_ID,PCTarget_ID,PCplus4_ID,alusrc_ID,alucontrol_ID,instr_ID[14:12],memwrite_ID,ResultSrc_ID,wdsel_ID,instr_ID[11:7]  ,regwrite_ID,instr_ID[19:15],instr_ID[24:20],branch_ID,instr_ID},
													   {rd1_EX,rd2_EX,immext_EX,PCTarget_EX,PCplus4_EX,alusrc_EX,alucontrol_EX,funct3_EX      ,memwrite_EX,ResultSrc_EX,wdsel_EX,regwrite_addr_EX,regwrite_EX,rs1_addr_EX    ,rs2_addr_EX    ,branch_EX,instr_EX});
	//floprc #(32) ID_EX_2(clk,reset,flushE,rd2_ID,rd2_EX);
	//floprc #(32) ID_EX_3(clk,reset,flushE,immext_ID,immext_EX);
	//floprc #(32) ID_EX_4(clk,reset,flushE,PCTarget_ID,PCTarget_EX);							
	//floprc #(32) ID_EX_5(clk,reset,flushE,PCplus4_ID,PCplus4_EX);
	//floprc #(1) ID_EX_6(clk,reset,flushE,alusrc_ID,alusrc_EX);
	//floprc #(1) ID_EX_7(clk,reset,flushE,jumpsel_ID,jumpsel_EX);				//removed
	//floprc #(4) ID_EX_8(clk,reset,flushE,alucontrol_ID,alucontrol_EX);
	//floprc #(3) ID_EX_9(clk,reset,flushE,instr_ID[14:12],funct3_EX);
	//floprc #(1) ID_EX_10(clk,reset,flushE,memwrite_ID,memwrite_EX);
	//floprc #(2) ID_EX_11(clk,reset,flushE,ResultSrc_ID,ResultSrc_EX);
	//floprc #(2) ID_EX_12(clk,reset,flushE,wdsel_ID,wdsel_EX);
	//floprc #(5) ID_EX_13(clk,reset,flushE,instr_ID[11:7],regwrite_addr_EX);
	//floprc #(1) ID_EX_14(clk,reset,flushE,regwrite_ID,regwrite_EX);
	//floprc #(5) ID_EX_15(clk,reset,flushE,instr_ID[19:15],rs1_addr_EX);
	//floprc #(5) ID_EX_16(clk,reset,flushE,instr_ID[24:20],rs2_addr_EX);
	//floprc #(1) ID_EX_17(clk,reset,flushE,branch_ID,branch_EX);
	//floprc #(32) ID_EX_18(clk,reset,flushE,instr_ID,instr_EX); //debugging pourpose only
	assign alu_src_out = alusrc_EX ? immext_EX : operand_2_EX;
	alu alu1(operand_1_EX,alu_src_out,alucontrol_EX,alu_out_EX,flags_EX);
	
		
	branchunit bu(flags_EX,funct3_EX,branch_EX,PCSrc_EX);
	
	assign operand_1_EX = control_1[1] ? alu_out_MEM : (control_1[0] ? wdmux_out_WB : rd1_EX);
	assign operand_2_EX = control_2[1] ? alu_out_MEM : (control_2[0] ? wdmux_out_WB : rd2_EX);
	
	//MEM stage
	flopr #(206) EX_MEM_1(clk,reset,{alu_out_EX ,operand_2_EX ,immext_EX ,PCTarget_EX ,PCplus4_EX ,memwrite_EX ,ResultSrc_EX ,wdsel_EX ,funct3_EX ,regwrite_addr_EX ,regwrite_EX ,instr_EX},
											  {alu_out_MEM,operand_2_MEM,immext_MEM,PCTarget_MEM,PCplus4_MEM,memwrite_MEM,ResultSrc_MEM,wdsel_MEM,funct3_MEM,regwrite_addr_MEM,regwrite_MEM,instr_MEM});
	//flopr #(32) EX_MEM_2(clk,reset,operand_2_EX,operand_2_MEM);
	//flopr #(32) EX_MEM_3(clk,reset,immext_EX,immext_MEM);
	//flopr #(32) EX_MEM_4(clk,reset,PCTarget_EX,PCTarget_MEM);
	//flopr #(32) EX_MEM_5(clk,reset,PCplus4_EX,PCplus4_MEM);
	//flopr #(1) EX_MEM_6(clk,reset,memwrite_EX,memwrite_MEM);
	//flopr #(2) EX_MEM_7(clk,reset,ResultSrc_EX,ResultSrc_MEM);
	//flopr #(2) EX_MEM_8(clk,reset,wdsel_EX,wdsel_MEM);
	//flopr #(3) EX_MEM_9(clk,reset,funct3_EX,funct3_MEM);
	//flopr #(5) EX_MEM_10(clk,reset,regwrite_addr_EX,regwrite_addr_MEM);
	//flopr #(1) EX_MEM_11(clk,reset,regwrite_EX,regwrite_MEM);
	//flopr #(32) EX_MEM_12(clk,reset,instr_EX,instr_MEM); //debugging pourpose only
	dmem dm(clk,memwrite_MEM,alu_out_MEM,rd2_out_MEM,dmem_out_MEM);
	store_unit su(funct3_MEM,operand_2_MEM,rd2_out_MEM);
	
	//WB stage
	flopr #(205) MEM_WB_1(clk,reset,{alu_out_MEM,dmem_out_MEM,PCTarget_MEM,immext_MEM,PCplus4_MEM,funct3_MEM,ResultSrc_MEM,wdsel_MEM,regwrite_addr_MEM,regwrite_MEM,instr_MEM},
											 {alu_out_WB ,dmem_out_WB ,PCTarget_WB ,immext_WB ,PCplus4_WB ,funct3_WB ,ResultSrc_WB ,wdsel_WB ,regwrite_addr_WB ,regwrite_WB ,instr_WB});
	//flopr #(32) MEM_WB_2(clk,reset,dmem_out_MEM,dmem_out_WB);
	//flopr #(32) MEM_WB_3(clk,reset,PCTarget_MEM,PCTarget_WB);
	//flopr #(32) MEM_WB_4(clk,reset,immext_MEM,immext_WB);
	//flopr #(32) MEM_WB_5(clk,reset,PCplus4_MEM,PCplus4_WB);
	//flopr #(3) MEM_WB_6(clk,reset,funct3_MEM,funct3_WB);
	//flopr #(2) MEM_WB_7(clk,reset,ResultSrc_MEM,ResultSrc_WB);
	//flopr #(2) MEM_WB_8(clk,reset,wdsel_MEM,wdsel_WB);
	//flopr #(5) MEM_WB_9(clk,reset,regwrite_addr_MEM,regwrite_addr_WB);
	//flopr #(1) MEM_WB_10(clk,reset,regwrite_MEM,regwrite_WB);
	//flopr #(32) MEM_WB_11(clk,reset,instr_MEM,instr_WB);
	
	
	assign result_WB = ResultSrc_WB[1] ? PCplus4_WB : (ResultSrc_WB[0] ? dmem_out_WB : alu_out_WB);

	assign wdmux_out_WB = wdsel_WB[0] ? (wdsel_WB[1] ? PCTarget_WB : result_out_WB) : (wdsel_WB[1] ? immext_WB : result_WB);
	
	load_unit lu(funct3_WB,result_WB,result_out_WB);	
	
	/****************************************************************************/
	
	assign control_ID_1={alucontrol_ID,3'b000,regwrite_ID,3'b000,alusrc_ID,3'b000,memwrite_ID,2'b00,wdsel_ID,1'b0,immSrc,2'b00,ResultSrc_ID,3'b000,jumpsel_ID};
	assign control_ID_2={8'h00,2'b00,aluop_wire_out_ID,3'b000,instr_ID[5],3'b000,instr_ID[30],1'b0,instr_ID[14:12],1'b0,instr_ID[6:0]};
	assign control_EX={2'b00,rs2_addr_EX,rs1_addr_EX,regwrite_addr_EX,funct3_EX,regwrite_EX,memwrite_EX,jumpsel_EX,alusrc_EX,wdsel_EX,ResultSrc_EX,alucontrol_EX};
	assign control_MEM={4'h0,3'b000,memwrite_MEM,2'b00,ResultSrc_MEM,2'b00,wdsel_MEM,1'b0,funct3_MEM,3'b000,regwrite_addr_MEM,3'b000,regwrite_MEM};
	assign control_WB={8'h00,1'b0,funct3_WB,2'b00,ResultSrc_WB,2'b00,wdsel_WB,3'b000,regwrite_addr_WB,3'b000,regwrite_WB};
	assign forward_control={26'b00_00000000_00000000_00000000,control_2,2'b00,control_1};
	assign branch_prediction={20'h00000,3'b000,flush_branch,3'b000,prediction,3'b000,PCSrc_EX};
	
	output_mux out(instr_IF,PC_IF,PCplus4_IF,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,
						instr_ID,immext_ID,rd1_ID,rd2_ID,PC_ID,PCplus4_ID,32'h00000000,32'h00000000,
						instr_EX,rd1_EX,rd2_EX,immext_EX,alu_out_EX,alu_src_out,operand_1_EX,operand_2_EX,
						instr_MEM,alu_out_MEM,rd2_out_MEM,dmem_out_MEM,rd2_MEM,immext_MEM,PCplus4_MEM,control_MEM,
						instr_WB,alu_out_WB,dmem_out_WB,result_WB,wdmux_out_WB,result_out_WB,immext_WB,PCplus4_WB,
						32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,
						branch_prediction,PCplus4,Target_PC,PCNext,32'h00000000,32'h00000000,32'h00000000,32'h00000000,
						control_ID_1,control_ID_2,control_EX,control_MEM,control_WB,forward_control,32'h00000000,32'h00000000,
						selm,
						hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
						
	//outside the pipeline
	
	forward_unit fwu(regwrite_WB,regwrite_MEM,rs1_addr_EX,rs2_addr_EX,regwrite_addr_MEM,regwrite_addr_WB,control_1,control_2);
	hazard_detection_unit hdu(instr_ID[19:15],instr_ID[24:20],regwrite_addr_EX,ResultSrc_EX[0],stallD,stallF,flushE);
	
	
	BranchPredictor BP(clk,reset,branch_ID,PC_ID,PCSrc_EX,prediction,delayed_branch_prediction2,flush_branch);			//flush_branch=misprediction
	TargetPC A(PCTarget_ID,flush_branch,reset,clk,Target_PC);
	PC_4 B(PCplus4_IF,flush_branch,reset,clk,PCplus4);
	PredictorSel Predictor_sel(prediction ,delayed_branch_prediction2,flush_branch ,predictionOut );
						
	
endmodule