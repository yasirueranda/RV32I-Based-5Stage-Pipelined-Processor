module top(reset ,clk,flags,instr_bus,rd1_bus,rd2_bus,result_bus,pc,pcnext,alucontrol_o);
	input wire reset,clk;
	output wire [3:0] flags;
	output wire [31:0] instr_bus,rd1_bus,rd2_bus,result_bus,pc,pcnext;
	output wire [3:0] alucontrol_o;
	
	wire [31:0] PCNext,PC,instr,rd1,rd2,result;
	wire [3:0] alucontrol;
	
	
	flopr #(32) pcreg(clk,reset,PCNext,PC);
	adder pcadder(PC,32'h00000004,PCNext);
	
	imem im(PC,instr);
	
	regfile rf(clk,reset,1'b1,instr[19:15],instr[24:20],instr[11:7],result,rd1,rd2);
	
	alu alu1(rd1,rd2,alucontrol,result,flags);
	
	aludec controller(2'b10,instr[14:12],instr[30],alucontrol);
	
	assign instr_bus=instr;
	assign rd1_bus=rd1;
	assign rd2_bus=rd2;
	assign result_bus=result;
	assign pc=PC;
	assign pcnext=PCNext;
	assign alucontrol_o=alucontrol;

	
endmodule