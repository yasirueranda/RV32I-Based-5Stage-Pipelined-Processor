module top(reset ,clk,flags,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	input wire reset,clk;
	input wire [1:0] selm;
	output wire [3:0] flags;
	output wire [6:0] hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0;
	
	wire [31:0] PCNext,PC,instr,rd1,rd2,result;
	wire [3:0] alucontrol;
	
	
	flopr #(32) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCNext);
	
	imem im(PC,instr);
	
	regfile rf(clk,1'b1,instr[19:15],instr[24:20],instr[11:7],result,rd1,rd2);
	
	alu alu1(rd1,rd2,alucontrol,result,flags);
	
	aludec controller(2'b10,instr[14:12],instr[30],alucontrol);
	
	output_mux out(rd1,rd2,result,instr,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
	
endmodule
	