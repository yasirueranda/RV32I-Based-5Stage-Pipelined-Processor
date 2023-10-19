module dmem(input logic clk,reset,we,
				input logic [31:0] a,wd,
				output logic [31:0] rd);
	logic [31:0] RAM[63:0];
	
	assign rd=RAM[a[31:2]]; //word alligned
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) 
			for (int i = 0; i < 64; i = i + 1)
                RAM[i] <= 32'h0;
		else if (we)
			RAM[a[31:2]]<=wd;
	end
	
	
endmodule
//here you will see that negedge clk, negedge rst thats because KEY0,1,2,3 are active low push buttons
//therefore if you give clk,rst from KEYs you need specify in negedge