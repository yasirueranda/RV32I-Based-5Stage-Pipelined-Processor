module dmem(input logic clk,we,
				input logic [31:0] a,wd,
				output logic [31:0] rd);
	logic [31:0] RAM[63:0];
	
	assign rd=RAM[a[3:2]]; //word alligned
	
	always_ff @(posedge clk)
		if (we) RAM[a[31:2]]<=wd;
endmodule

//here you will see that negedge clk, negedge rst thats because KEY0,1,2,3 are active low push buttons
//therefore if you give clk,rst from KEYs you need specify in negedge