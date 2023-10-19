module dmem(input logic clk,we1,we2,
				input logic [31:0] a1,a2,wd1,wd2,
				output logic [31:0] rd1,rd2);
	logic [31:0] RAM[63:0];
	
	assign rd1=RAM[a1[31:2]]; //word alligned
	assign rd2=RAM[a2[31:2]]; //word alligned
	
	always_ff @(negedge clk) begin
		if (we1) RAM[a1[31:2]]<=wd1;
		if (we2) RAM[a2[31:2]]<=wd2;
	end
endmodule


//here you will see that negedge clk, negedge rst thats because KEY0,1,2,3 are active low push buttons
//therefore if you give clk,rst from KEYs you need specify in negedge