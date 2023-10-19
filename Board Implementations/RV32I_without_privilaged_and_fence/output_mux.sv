module output_mux(input wire [31:0] pcnext,pc,pcplus4,pctarget,instr,rd1,rd2,result,alu_src_out,immext,rd2_out,result_out,alu_out,dmem_out,wdmux_out,control,
						input wire [3:0] selm,
						output wire [6:0] HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
						
	wire [31:0] out_bus;
						
	always_comb begin
    case (selm)
        4'b0000: out_bus = instr;
        4'b0001: out_bus = rd1;
        4'b0010: out_bus = rd2;
        4'b0011: out_bus = immext;
		  4'b0100: out_bus = alu_src_out;
		  4'b0101: out_bus = alu_out;
		  4'b0110: out_bus = dmem_out;
		  4'b0111: out_bus = pcplus4;
		  4'b1000: out_bus = result;
		  4'b1001: out_bus = rd2_out;
		  4'b1010: out_bus = result_out;
		  4'b1011: out_bus = wdmux_out;
		  4'b1100: out_bus = pcnext;
		  4'b1101: out_bus = pc;
		  4'b1110: out_bus = pctarget;
		  4'b1111: out_bus = control;
        default: out_bus = 32'h00000000;
    endcase
	end
					  
	hexcoder h0(out_bus[3:0],HEX0);
	hexcoder h1(out_bus[7:4],HEX1);
	hexcoder h2(out_bus[11:8],HEX2);
	hexcoder h3(out_bus[15:12],HEX3);
	hexcoder h4(out_bus[19:16],HEX4);
	hexcoder h5(out_bus[23:20],HEX5);
	hexcoder h6(out_bus[27:24],HEX6);
	hexcoder h7(out_bus[31:28],HEX7);
endmodule