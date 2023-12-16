module imem(input logic[31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[31:0];
	
	initial begin
		RAM[0]=32'h02800813;
		RAM[1]=32'hFF400893;
		RAM[2]=32'h02800913;
		RAM[3]=32'h03800993;
	end
	
	assign rd=RAM[a[31:2]]; //word aligned 
	
endmodule