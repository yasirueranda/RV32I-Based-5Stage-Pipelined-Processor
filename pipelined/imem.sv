module imem(input logic[31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[63:0];
	
	initial begin
	
		//RAM[0]=32'h02800813;
		//RAM[1]=32'hFF400893;
		//RAM[2]=32'h02800913;
		//RAM[3]=32'h03800993;
		
		/*//lui
		RAM[0]=32'h0003A437;
		RAM[1]=32'h00100013;
		RAM[2]=32'h7D040413;
		
		//load and store
		RAM[3]=32'h00802023;
		RAM[4]=32'h00801223;
		RAM[5]=32'h00800423;
		RAM[6]=32'h00000183;
		RAM[7]=32'h00004203;
		RAM[8]=32'h00001283;
		RAM[9]=32'h00005303;
		RAM[10]=32'h00002383;*/
		
		//I-arithematic
		/*RAM[15]=32'h00500093;
		RAM[16]=32'h0040A113;
		RAM[17]=32'hFE514113;
		RAM[18]=32'h00C13193;
		RAM[19]=32'h00C1E113;
		RAM[20]=32'hFFF17193;
		RAM[21]=32'h00119113;
		RAM[22]=32'h00115193;
		RAM[23]=32'hFE504113;
		RAM[24]=32'h40215193;
		RAM[25]=32'h01C1D213;*/
		/*
		//branch and R type
		RAM[25]=32'h01280E63;
		RAM[26]=32'h41DF0FB3;
		RAM[27]=32'h0328C263;
		RAM[28]=32'h01EEFFB3;
		RAM[29]=32'h03186263;
		RAM[30]=32'h01EE8FB3;
		RAM[31]=32'h02400C6F;
		RAM[32]=32'h00200E93;
		RAM[33]=32'h00A00F13;
		RAM[34]=32'h01EE8FB3;
		RAM[35]=32'hFD381EE3;
		RAM[36]=32'h01EEEFB3;
		RAM[37]=32'hFD09DEE3;
		RAM[38]=32'h01EECFB3;
		RAM[39]=32'hFD38FEE3;
		RAM[40]=32'h0040A0B3;
		RAM[41]=32'h00C00193;
		RAM[42]=32'h00119133;
		RAM[43]=32'h001151B3;
		RAM[44]=32'hFE504113;
		RAM[45]=32'h00200093;
		RAM[46]=32'h401151B3;
		RAM[47]=32'h01C00093;
		RAM[48]=32'h00113233;
		RAM[49]=32'h00000E67; */
		
		
		RAM[0]=32'h00500093;
		RAM[1]=32'h00000113;
		RAM[2]=32'h00100113;
		RAM[3]=32'hFE209EE3;
		RAM[4]=32'h00100013;
		RAM[5]=32'h00200013;
		RAM[6]=32'h00300013;
		
	end
	
	assign rd=RAM[a[31:2]]; //word aligned 
	
endmodule