module output_mux(input wire [31:0] rd1_bus,rd2_bus,result_bus,instr_bus,
						input wire [1:0] selm,
						output wire [6:0] HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
						
	wire [31:0] out_bus;
						
	always_comb begin
    case (selm)
        2'b00: out_bus = instr_bus;
        2'b01: out_bus = rd1_bus;
        2'b10: out_bus = rd2_bus;
        2'b11: out_bus = result_bus;
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
