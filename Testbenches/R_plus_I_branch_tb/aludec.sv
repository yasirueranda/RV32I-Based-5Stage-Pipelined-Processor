module aludec(input wire [1:0] ALUop,
				  input wire [2:0] funct3,
				  input wire funct75,
				  output wire [3:0] ALUControl);
	// Declare a ROM with 2^7 (128) entries and 4 bits per entry
    reg [3:0] rom [0:63];
	 
	 wire [5:0] addr;
	 
	 assign addr={ALUop,funct3,funct75};
	 
	 
    initial begin
		  rom[6'b01xxxx] = 4'b0001;						// sub for branch
		  rom[6'b100000] = 4'b0000; 						// add
		  rom[6'b100001] = 4'b0001; 						// sub
		  rom[6'b100010] = 4'b0110; 						// sll
		  rom[6'b100100] = 4'b0101; 						// slt
		  rom[6'b100110] = 4'b1001; 						// sltu
		  rom[6'b101000] = 4'b0100; 						// xor
		  rom[6'b101010] = 4'b0111; 						// srl
		  rom[6'b101011] = 4'b1000; 						// sra
		  rom[6'b101100] = 4'b0011; 						// or
		  rom[6'b101110] = 4'b0010; 						// and     
    end

    // Read from the ROM based on the opcode
    assign ALUControl = rom[addr];
	 
endmodule