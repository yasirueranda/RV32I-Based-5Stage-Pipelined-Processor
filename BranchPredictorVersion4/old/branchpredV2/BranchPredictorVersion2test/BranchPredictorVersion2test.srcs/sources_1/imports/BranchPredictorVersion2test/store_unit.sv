module store_unit(input wire [2:0] funct3,
							 input wire [31:0] rd2,
							 output wire [31:0] rd2_out);
	always_comb begin
    case (funct3)
			3'b000: rd2_out={24'b00000000_00000000_00000000,rd2[7:0]};	//sb
			3'b001: rd2_out={16'b00000000_00000000,rd2[15:0]};				//sh
			3'b010: rd2_out=rd2;														//sw
			default: rd2_out = 32'hxxxx_xxxx;		
    endcase
	end
endmodule