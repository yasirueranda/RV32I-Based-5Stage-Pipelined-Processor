module output_mux(input wire [31:0] s1_b1,s1_b2,s1_b3,s1_b4,s1_b5,s1_b6,s1_b7,s1_b8,
						input wire [31:0] s2_b1,s2_b2,s2_b3,s2_b4,s2_b5,s2_b6,s2_b7,s2_b8,
						input wire [31:0] s3_b1,s3_b2,s3_b3,s3_b4,s3_b5,s3_b6,s3_b7,s3_b8,
						input wire [31:0] s4_b1,s4_b2,s4_b3,s4_b4,s4_b5,s4_b6,s4_b7,s4_b8,
						input wire [31:0] s5_b1,s5_b2,s5_b3,s5_b4,s5_b5,s5_b6,s5_b7,s5_b8,
						input wire [31:0] s6_b1,s6_b2,s6_b3,s6_b4,s6_b5,s6_b6,s6_b7,s6_b8,
						input wire [31:0] s7_b1,s7_b2,s7_b3,s7_b4,s7_b5,s7_b6,s7_b7,s7_b8,
						input wire [31:0] s8_b1,s8_b2,s8_b3,s8_b4,s8_b5,s8_b6,s8_b7,s8_b8,
						input wire [5:0] selm,
						output wire [6:0] HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0);
						
	wire [31:0] out_bus;
						
	always_comb begin
    case (selm)
        6'b000_000: out_bus = s1_b1;
        6'b000_001: out_bus = s1_b2;
        6'b000_010: out_bus = s1_b3;
        6'b000_011: out_bus = s1_b4;
		  6'b000_100: out_bus = s1_b5;
		  6'b000_101: out_bus = s1_b6;
		  6'b000_110: out_bus = s1_b7;
		  6'b000_111: out_bus = s1_b8;
		  
		  6'b001_000: out_bus = s2_b1;
		  6'b001_001: out_bus = s2_b2;
		  6'b001_010: out_bus = s2_b3;
		  6'b001_011: out_bus = s2_b4;
		  6'b001_100: out_bus = s2_b5;
		  6'b001_101: out_bus = s2_b6;
		  6'b001_110: out_bus = s2_b7;
		  6'b001_111: out_bus = s2_b8;
		  
		  6'b010_000: out_bus = s3_b1;
        6'b010_001: out_bus = s3_b2;
        6'b010_010: out_bus = s3_b3;
        6'b010_011: out_bus = s3_b4;
		  6'b010_100: out_bus = s3_b5;
		  6'b010_101: out_bus = s3_b6;
		  6'b010_110: out_bus = s3_b7;
		  6'b010_111: out_bus = s3_b8;
		  
		  6'b011_000: out_bus = s4_b1;
		  6'b011_001: out_bus = s4_b2;
		  6'b011_010: out_bus = s4_b3;
		  6'b011_011: out_bus = s4_b4;
		  6'b011_100: out_bus = s4_b5;
		  6'b011_101: out_bus = s4_b6;
		  6'b011_110: out_bus = s4_b7;
		  6'b011_111: out_bus = s4_b8;
		  
		  6'b100_000: out_bus = s5_b1;
        6'b100_001: out_bus = s5_b2;
        6'b100_010: out_bus = s5_b3;
        6'b100_011: out_bus = s5_b4;
		  6'b100_100: out_bus = s5_b5;
		  6'b100_101: out_bus = s5_b6;
		  6'b100_110: out_bus = s5_b7;
		  6'b100_111: out_bus = s5_b8;
		  
		  6'b101_000: out_bus = s6_b1;
		  6'b101_001: out_bus = s6_b2;
		  6'b101_010: out_bus = s6_b3;
		  6'b101_011: out_bus = s6_b4;
		  6'b101_100: out_bus = s6_b5;
		  6'b101_101: out_bus = s6_b6;
		  6'b101_110: out_bus = s6_b7;
		  6'b101_111: out_bus = s6_b8;
		 
		  6'b110_000: out_bus = s7_b1;
        6'b110_001: out_bus = s7_b2;
        6'b110_010: out_bus = s7_b3;
        6'b110_011: out_bus = s7_b4;
		  6'b110_100: out_bus = s7_b5;
		  6'b110_101: out_bus = s7_b6;
		  6'b110_110: out_bus = s7_b7;
		  6'b110_111: out_bus = s7_b8;
		  
		  6'b111_000: out_bus = s8_b1;
		  6'b111_001: out_bus = s8_b2;
		  6'b111_010: out_bus = s8_b3;
		  6'b111_011: out_bus = s8_b4;
		  6'b111_100: out_bus = s8_b5;
		  6'b111_101: out_bus = s8_b6;
		  6'b111_110: out_bus = s8_b7;
		  6'b111_111: out_bus = s8_b8;
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