module top(reset ,clk,flags,pc_o,pcnext_o,instr_o,rd1_o,rd2_o,result_o,alu_src_out_o,immext_o);
	input wire reset,clk;
	output wire [3:0] flags;
	output wire [31:0] pc_o,pcnext_o,instr_o,rd1_o,rd2_o,result_o,alu_src_out_o,immext_o;
	
	wire [31:0] PCNext,PC,instr,rd1,rd2,result,alu_src_out,immext;
	wire [3:0] alucontrol;
	wire regwrite,alusrc;
	
	
	flopr #(32) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCNext);
	
	imem im(PC,instr);
	
	regfile rf(clk,reset,regwrite,instr[19:15],instr[24:20],instr[11:7],result,rd1,rd2);
	
	extend ex(instr[31:20],immext);
	
	alu alu1(rd1,alu_src_out,alucontrol,result,flags);
	
	controller controller1(instr[6:0],instr[14:12],instr[30],alucontrol,regwrite,alusrc);
	
	assign alu_src_out = alusrc ? immext : rd2;
	
	assign pc_o=PC;
	assign pcnext_o=PCNext;
	assign instr_o=instr;
	assign rd1_o=rd1;
	assign rd2_o=rd2;
	assign result_o=result;
	assign alu_src_out_o=alu_src_out;
	assign immext_o=immext;
	
endmodule