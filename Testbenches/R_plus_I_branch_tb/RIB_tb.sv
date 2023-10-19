`timescale 1ns/10ps

module RIB_tb;
	reg reset,clk;
	wire [3:0] flags;
	wire [31:0] PCNext,PC,PCplus4,PCTarget,instr,rd1,rd2,result,alu_src_out,immext;
	
	top top1(reset ,clk,flags,PCNext,PC,PCplus4,PCTarget,instr,rd1,rd2,result,alu_src_out,immext);
	
	always begin;
		#5 clk=~clk;
	end
	
	initial begin
		clk = 1'b0;
		reset = 1'b1;
	end
	
	initial begin
		#1; reset= 1'b0;
		#4;
		#5;
		#5;
		#5;
		#5;
		$stop;
		$finish;
	end
endmodule