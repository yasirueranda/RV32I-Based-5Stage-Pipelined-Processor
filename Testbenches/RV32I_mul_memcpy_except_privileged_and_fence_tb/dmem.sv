module dmem(input logic clk,reset,we1,we2,
				input logic [31:0] a1,a2,wd1,wd2,
				output logic [31:0] rd1,rd2);
	logic [31:0] RAM[63:0];
	
	assign rd1=RAM[a1[31:2]]; //word alligned
	assign rd2=RAM[a2[31:2]]; //word alligned
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) 
			for (int i = 0; i < 64; i = i + 1)
                RAM[i] <= 32'h0;
		else if (we1)
			RAM[a1[31:2]]<=wd1;
		else if (we2)
			RAM[a2[31:2]]<=wd2;
	end
endmodule


//here you will see that negedge clk, negedge rst thats because KEY0,1,2,3 are active low push buttons
//therefore if you give clk,rst from KEYs you need specify in negedge