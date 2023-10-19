module extend(input logic [11:0] imm,
				  output logic [31:0] immext);
	assign immext={{20{imm[11]}},imm[11:0]};
endmodule