module load_unit(input wire [2:0] funct3,
							 input wire [31:0] result,
							 output reg [31:0] result_out);
							 
	always_comb begin
    case (funct3)
			3'b000: result_out={{24{result[7]}},result[7:0]};					//lb
			3'b001: result_out={{16{result[15]}},result[15:0]};		   	//lh
			3'b010: result_out=result;											   	//lw
			3'b100: result_out={{24'b00000000_00000000_00000000},result[7:0]};	//lbu
			3'b101: result_out={{16'b00000000_00000000},result[15:0]};				//lhu
			default: result_out = 32'hxxxx_xxxx;		
    endcase
	end
endmodule