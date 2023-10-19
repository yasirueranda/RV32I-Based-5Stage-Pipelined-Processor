module imem(input logic[31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[31:0];
	
	initial begin
		RAM[0]=32'h00500093;
		RAM[1]=32'h0040A113;
		RAM[2]=32'hFE514113;
		RAM[3]=32'h00C13193;
		RAM[4]=32'h00C1E113;
		RAM[5]=32'hFFF17193;
		RAM[6]=32'h00119113;
		RAM[7]=32'h00115193;
		RAM[8]=32'hFE504113;
		RAM[9]=32'h40215193;
		RAM[10]=32'h01C1D213;
	end
	
	assign rd=RAM[a[31:2]]; //word aligned 
	
endmodule