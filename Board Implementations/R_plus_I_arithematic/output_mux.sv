module output_mux(input wire [31:0] control,pc,instr,rd1,rd2,result,alu_src_out,immext,
						input wire [2:0] selm,
						output wire [6:0] HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
						
	wire [31:0] out_bus;
						
	always_comb begin
    case (selm)
        3'b000: out_bus = instr;
        3'b001: out_bus = rd1;
        3'b010: out_bus = rd2;
        3'b011: out_bus = result;
		  3'b100: out_bus = immext;
        3'b101: out_bus = alu_src_out;
        3'b110: out_bus = pc;
        3'b111: out_bus = control;
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