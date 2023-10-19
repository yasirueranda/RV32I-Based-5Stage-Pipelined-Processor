module imem(input logic[31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[31:0];
	
	initial begin
		RAM[0]=32'h00208333;
		RAM[1]=32'h40110333;
		RAM[2]=32'h40208333;
		RAM[3]=32'h00327333;
		RAM[4]=32'h00326333;
	end
	
	assign rd=RAM[a[31:2]]; //word aligned 
	
endmodule