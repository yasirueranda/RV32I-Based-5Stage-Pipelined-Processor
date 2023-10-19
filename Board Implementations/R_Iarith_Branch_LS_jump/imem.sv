module imem(input logic[31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[31:0];
	
	initial begin
		RAM[0]=32'h00500113;
		RAM[1]=32'h00C00193;
		RAM[2]=32'hFF718393;
		RAM[3]=32'h0023E233;
		RAM[4]=32'h0041F2B3;
		RAM[5]=32'h004282B3;
		RAM[6]=32'h02728863;
		RAM[7]=32'h0041A233;
		RAM[8]=32'h00020463;
		RAM[9]=32'h00000293;
		RAM[10]=32'h0023A233;
		RAM[11]=32'h005203B3;
		RAM[12]=32'h402383B3;
		RAM[13]=32'h0471AA23;
		RAM[14]=32'h06002103;
		RAM[15]=32'h005104B3;
		RAM[16]=32'h008001EF;
		RAM[17]=32'h00100113;
		RAM[18]=32'h00910133;
		RAM[19]=32'h0221A023;
		RAM[20]=32'h00210063;
	end
	
	assign rd=RAM[a[31:2]]; //word aligned 
	
endmodule