module top(reset ,clk,flags,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	input wire reset,clk;
	input wire [2:0] selm;
	output wire [3:0] flags;
	output wire [6:0] hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0;
	
	wire [31:0] PCNext,PC,instr,rd1,rd2,result,alu_src_out,immext,control;
	wire [3:0] alucontrol;
	wire regwrite,alusrc;
	
	
	flopr #(32) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCNext);
	
	imem im(PC,instr);
	
	regfile rf(clk,regwrite,instr[19:15],instr[24:20],instr[11:7],result,rd1,rd2);
	
	extend ex(instr[31:20],immext);
	
	alu alu1(rd1,alu_src_out,alucontrol,result,flags);
	
	controller controller1(instr[6:0],instr[14:12],instr[30],instr[5],alucontrol,alusrc,regwrite);
	
	assign control={14'b00_0000_0000,instr[6:0],instr[14:12],instr[30],instr[5],alusrc,regwrite,alucontrol};
	
	output_mux out(control,PC,instr,rd1,rd2,result,alu_src_out,immext,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	
	assign alu_src_out = alusrc ? immext : rd2;
	
endmodule
	