`timescale 1ns/10ps

module top;
	reg reset,clk;
	wire [3:0] flags;
	wire [31:0] pcnext,pc,pcplus4,pctarget,instr,rd1,rd2,result,alu_src_out,immext,rd2_out,result_out,alu_out,dmem_out1,dmem_out2,wdmux_out,control,array_out;
	
	cpu cpu1(reset,clk,flags,pcnext,pc,pcplus4,pctarget,instr,rd1,rd2,result,alu_src_out,immext,rd2_out,result_out,alu_out,dmem_out1,dmem_out2,wdmux_out,control,array_out);
	
	always begin;
		#5 clk=~clk;
	end
	
	initial begin
		clk=1'b1;
		reset=1'b1;
	end
	
	initial begin
		#1 reset=1'b0;
		#4;
		#55; 
		$stop;
		$finish;
	end
endmodule

//any memory if it has clocked input then 
//if you want simulate in modelsim a digital system with that memory then you need to give a 
//reset signal to those memories and initially reset those memories in simulation 