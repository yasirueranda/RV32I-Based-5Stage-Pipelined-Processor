`timescale 1ns/10ps

module top_tb;
	reg reset,clk;
	wire [3:0] flags;
	wire [31:0] instr_bus,rd1_bus,rd2_bus,result_bus,pc,pcnext;
	wire [3:0] alucontrol;
	
	top top1(reset,clk,flags,instr_bus,rd1_bus,rd2_bus,result_bus,pc,pcnext,alucontrol);
	
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
