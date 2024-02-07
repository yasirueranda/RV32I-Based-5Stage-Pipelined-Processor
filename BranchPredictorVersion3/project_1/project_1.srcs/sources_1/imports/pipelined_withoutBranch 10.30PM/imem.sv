module imem(input logic[31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[63:0];
	
	initial begin
	
		//lui
		RAM[0]=32'h0003A437;
		RAM[1]=32'h00100013;
		RAM[2]=32'h7D040413;
		
		//load and store
		RAM[3]=32'h00802023;
		RAM[4]=32'h00801223;
		RAM[5]=32'h00800423;
		RAM[7]=32'h00000183;
		RAM[8]=32'h00004203;
		RAM[9]=32'h00001283;
		RAM[10]=32'h00005303;
		RAM[11]=32'h00002383;
		
		//I-arithematic
		RAM[12]=32'h00500093;
		RAM[13]=32'h0040A113;
		RAM[14]=32'hFE514113;
		RAM[15]=32'h00C13193;
		RAM[16]=32'h00C1E113;
		RAM[17]=32'hFFF17193;
		RAM[18]=32'h00119113;
		RAM[19]=32'h00115193;
		RAM[20]=32'hFE504113;
		RAM[21]=32'h40215193;
		RAM[22]=32'h01C1D213;
	end
	
	assign rd=RAM[a[31:2]]; //word aligned 
	
endmodule