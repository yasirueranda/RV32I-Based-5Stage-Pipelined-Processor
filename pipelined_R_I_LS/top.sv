module top(reset ,clk,flags_EX,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	input wire reset,clk;
	input wire [5:0] selm;
	output wire [3:0] flags_EX;
	output wire [6:0] hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0;
	
	wire [31:0] control_ID,control_EX,control_MEM,control_WB;
	
	/***********************************************************/
	
	//IF stage
	wire [31:0] PC,PCplus4,instr_IF;
	//ID stage
	wire [31:0] instr_ID,immext_ID,rd1_ID,rd2_ID;
	wire [3:0] alucontrol_ID;
	wire immSrc,regwrite_ID,alusrc_ID,memwrite_ID,wdsel_ID,ResultSrc_ID;
	//EX stage
	wire [31:0] rd1_EX,rd2_EX,immext_EX,alu_out_EX,alu_src_out;
	wire [4:0] regwrite_addr_EX;
	wire [3:0] alucontrol_EX;
	wire [2:0] funct3_EX;
	wire alusrc_EX,memwrite_EX,ResultSrc_EX,wdsel_EX;
	//MEM stage
	wire [31:0] alu_out_MEM,rd2_out_MEM,dmem_out_MEM,rd2_MEM;
	wire [4:0] regwrite_addr_MEM;
	wire [2:0] funct3_MEM;
	wire memwrite_MEM,ResultSrc_MEM,wdsel_MEM;
	//WB stage
	wire [31:0] alu_out_WB,dmem_out_WB,result_WB,wdmux_out_WB,result_out_WB;
	wire [4:0] regwrite_addr_WB;
	wire [2:0] funct3_WB;
	wire ResultSrc_WB,wdsel_WB;
	
	/******************************************************************/
	
	
	
	//IF stage
	flopr #(32) pcreg(clk,reset,PCplus4,PC);
	adder pcadder(PC,32'h00000004,PCplus4);
	imem im(PC,instr_IF);
	
	//ID stage
	flopr #(32) IF_ID(clk,reset,instr_IF,instr_ID);
	controller controller1(instr_ID[6:0],instr_ID[14:12],instr_ID[30],instr_ID[5],alucontrol_ID,regwrite_ID,alusrc_ID,memwrite_ID,wdsel_ID,immSrc,ResultSrc_ID);
	regfile rf(clk,regwrite_WB,instr_ID[19:15],instr_ID[24:20],regwrite_addr_WB,wdmux_out_WB,rd1_ID,rd2_ID);
	extend ex(instr_ID[31:7],immSrc,immext_ID);
	
	//EX stage
	flopr #(32) ID_EX_1(clk,reset,rd1_ID,rd1_EX);
	flopr #(32) ID_EX_2(clk,reset,rd2_ID,rd2_EX);
	flopr #(32) ID_EX_3(clk,reset,immext_ID,immext_EX);
	flopr #(1) ID_EX_4(clk,reset,alusrc_ID,alusrc_EX);
	flopr #(4) ID_EX_5(clk,reset,alucontrol_ID,alucontrol_EX);
	flopr #(3) ID_EX_6(clk,reset,instr_ID[14:12],funct3_EX);
	flopr #(1) ID_EX_7(clk,reset,memwrite_ID,memwrite_EX);
	flopr #(1) ID_EX_8(clk,reset,ResultSrc_ID,ResultSrc_EX);
	flopr #(1) ID_EX_9(clk,reset,wdsel_ID,wdsel_EX);
	flopr #(5) ID_EX_10(clk,reset,instr_ID[11:7],regwrite_addr_EX);
	assign alu_src_out = alusrc_EX ? immext_EX : rd2_EX;
	alu alu1(rd1_EX,alu_src_out,alucontrol_EX,alu_out_EX,flags_EX);
	
	//MEM stage
	flopr #(32) EX_MEM_1(clk,reset,alu_out_EX,alu_out_MEM);
	flopr #(32) EX_MEM_2(clk,reset,rd2_EX,rd2_MEM);
	flopr #(1) EX_MEM_3(clk,reset,memwrite_EX,memwrite_MEM);
	flopr #(1) EX_MEM_4(clk,reset,ResultSrc_EX,ResultSrc_MEM);
	flopr #(1) EX_MEM_5(clk,reset,wdsel_EX,wdsel_MEM);
	flopr #(3) EX_MEM_6(clk,reset,funct3_EX,funct3_MEM);
	flopr #(5) EX_MEM_7(clk,reset,regwrite_addr_EX,regwrite_addr_MEM);
	dmem dm(clk,memwrite_MEM,alu_out_MEM,rd2_out_MEM,dmem_out_MEM);
	store_unit su(funct3_MEM,rd2_MEM,rd2_out_MEM);
	
	//WB stage
	flopr #(32) MEM_WB_1(clk,reset,alu_out_MEM,alu_out_WB);
	flopr #(32) MEM_WB_2(clk,reset,dmem_out_MEM,dmem_out_WB);
	flopr #(3) MEM_WB_3(clk,reset,funct3_MEM,funct3_WB);
	flopr #(1) MEM_WB_4(clk,reset,ResultSrc_MEM,ResultSrc_WB);
	flopr #(1) MEM_WB_5(clk,reset,wdsel_MEM,wdsel_WB);
	flopr #(5) MEM_WB_6(clk,reset,regwrite_addr_WB,regwrite_addr_WB);
	assign result_WB = ResultSrc_WB ? dmem_out_WB : alu_out_WB;
	assign wdmux_out_WB = wdsel_WB ? result_out_WB : result_WB;
	load_unit lu(funct3_WB,result_WB,result_out_WB);	
	
	/****************************************************************************/
	
	assign control_ID=32'h00000000;
	assign control_EX=32'h00000000;
	assign control_MEM=32'h00000000;
	assign control_WB=32'h00000000;
	
	output_mux out(PC,PCplus4,instr_IF,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,
						instr_ID,immext_ID,rd1_ID,rd2_ID,control_ID,32'h00000000,32'h00000000,32'h00000000,
						rd1_EX,rd2_EX,immext_EX,alu_out_EX,alu_src_out,control_EX,32'h00000000,32'h00000000,
						alu_out_MEM,rd2_out_MEM,dmem_out_MEM,rd2_MEM,control_MEM,32'h00000000,32'h00000000,32'h00000000,
						alu_out_WB,dmem_out_WB,result_WB,wdmux_out_WB,result_out_WB,control_WB,32'h00000000,32'h00000000,
						32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,
						32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,
						32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,32'h00000000,
						selm,
						hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
						
	
endmodule