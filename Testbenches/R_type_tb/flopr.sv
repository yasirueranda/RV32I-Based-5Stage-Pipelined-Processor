module flopr #(parameter WIDTH=32)
				(input logic clk,reset,
				 input logic [WIDTH-1:0] d,
				 output logic [WIDTH-1:0] q);
				 
	always_ff @(posedge clk,posedge reset)
		if(reset) q<=0;
		else 		 q<=d;
endmodule

//here you will see that negedge clk, negedge rst thats because KEY0,1,2,3 are active low push buttons
//therefore if you give clk,rst from KEYs you need specify in negedge