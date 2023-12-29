module extend(input logic [24:0] imm,
				  input logic [2:0] immsrc,
				  output logic [31:0] immext);
	
	always_comb begin
    case (immsrc)
        3'b000: immext= {{20{imm[24]}},imm[24:13]};												//I type
        3'b001: immext= {{20{imm[24]}},imm[0],imm[23:18],imm[4:1],1'b0}; 					//B type
		  3'b010: immext= {{20{imm[24]}},imm[24:18],imm[4:0]};       							//S type
		  3'b011: immext= {{12{imm[24]}},imm[12:5],imm[13],imm[23:14],1'b0};					//J type
		  3'b100: immext= {imm[24:5],12'b0000_0000_0000};											//U type
        default: immext = 32'hxxxx_xxxx;
    endcase
	end
	
endmodule
