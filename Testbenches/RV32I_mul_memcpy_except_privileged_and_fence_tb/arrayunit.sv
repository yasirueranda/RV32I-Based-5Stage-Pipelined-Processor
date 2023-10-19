module arrayunit(input wire [2:0] funct3,
					  input wire [31:0] dmem_out1,dmem_out2,
					  output logic [31:0] array_out);
	always_comb begin
		case(funct3)
			3'b000 : array_out = {dmem_out2[31:4],dmem_out1[3:0]};
			3'b001 : array_out = {dmem_out2[31:8],dmem_out1[7:0]};
			3'b010 : array_out = {dmem_out2[31:12],dmem_out1[11:0]};
			3'b011 : array_out = {dmem_out2[31:16],dmem_out1[15:0]};
			3'b100 : array_out = {dmem_out2[31:20],dmem_out1[19:0]};
			3'b101 : array_out = {dmem_out2[31:24],dmem_out1[23:0]};
			3'b110 : array_out = {dmem_out2[31:28],dmem_out1[27:0]};
			3'b111 : array_out = dmem_out1;
			default : array_out = 32'hxxxx_xxxx;
		endcase
	end
endmodule

			