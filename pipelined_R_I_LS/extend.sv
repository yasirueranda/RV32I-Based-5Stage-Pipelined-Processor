module extend(input logic [24:0] imm,
				  input logic immsrc,
				  output logic [31:0] immext);
	
	always_comb begin
    case (immsrc)
        1'b0: immext= {{20{imm[24]}},imm[24:13]};										//I type
		  1'b1: immext= {{20{imm[24]}},imm[24:18],imm[4:0]};       				//S type
        default: immext = 32'hxxxx_xxxx;
    endcase
	end
	
endmodule
