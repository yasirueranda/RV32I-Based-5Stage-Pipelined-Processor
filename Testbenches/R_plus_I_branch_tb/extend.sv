module extend(input logic [24:0] imm,
				  input logic immsrc,
				  output logic [31:0] immext);
	
	always_comb begin
    case (immsrc)
        1'b0: immext= {{20{imm[24]}},imm[24:13]};
        1'b1: immext= {{20{imm[24]}},imm[0],imm[23:18],imm[4:1],1'b0};
        default: immext = 32'h0000_0000;
    endcase
	end
	
endmodule