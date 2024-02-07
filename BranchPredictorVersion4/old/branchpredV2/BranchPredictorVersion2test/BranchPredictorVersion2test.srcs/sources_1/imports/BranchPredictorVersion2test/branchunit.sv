module branchunit(input wire [3:0] flags,
						input wire [2:0] funct3,
						input wire branch,
						output wire PCSrc);
	wire one,two,three,mux_out;
	always_comb
		begin
		one=funct3[0]^flags[0];									//beq,bne
		two=funct3[0]^(flags[1]^flags[3]);					//blt,bge
		three=funct3[0]^ (~flags[2]);							//bltu,bgeu
		end
	
	always_comb begin
    case (funct3[2:1])
        2'b00: mux_out= one;
        2'b01: mux_out= 1'b0;
        2'b10: mux_out= two;
        2'b11: mux_out= three;
        default: mux_out = 1'b0;
    endcase
	end
	
	assign PCSrc= mux_out & branch;
	
endmodule

//flags : {o,c,n,z}