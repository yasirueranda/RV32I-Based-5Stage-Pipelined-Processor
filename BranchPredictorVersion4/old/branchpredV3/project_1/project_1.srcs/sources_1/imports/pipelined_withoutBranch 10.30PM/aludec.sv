module aludec(input wire [1:0] ALUop,
				  input wire [2:0] funct3,
				  input wire funct75,
				  input wire op5,
				  output wire [3:0] ALUControl);
	// Declare a ROM with 2^7 (128) entries and 4 bits per entry
    reg [3:0] rom [0:127];
	 
	 wire [6:0] addr;
	 
	 assign addr={ALUop,funct3,op5,funct75};
	 
	 
    initial begin
		  //00
		  rom[7'b00_000_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_000_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_000_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_000_1_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_001_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_001_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_001_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_001_1_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_010_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_010_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_010_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_010_1_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_011_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_011_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_011_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_011_1_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_100_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_100_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_100_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_100_1_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_101_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_101_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_101_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_101_1_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_110_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_110_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_110_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_110_1_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_111_0_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_111_0_1] = 4'b0000;						// add for lw and sw
		  rom[7'b00_111_1_0] = 4'b0000;						// add for lw and sw
		  rom[7'b00_111_1_1] = 4'b0000;						// add for lw and sw
		  
		  //01
		  rom[7'b01_000_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_000_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_000_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_000_1_1] = 4'b0001;						// sub for branch
		  rom[7'b01_001_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_001_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_001_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_001_1_1] = 4'b0001;						// sub for branch
		  rom[7'b01_010_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_010_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_010_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_010_1_1] = 4'b0001;						// sub for branch
		  rom[7'b01_011_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_011_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_011_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_011_1_1] = 4'b0001;						// sub for branch
		  rom[7'b01_100_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_100_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_100_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_100_1_1] = 4'b0001;						// sub for branch
		  rom[7'b01_101_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_101_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_101_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_101_1_1] = 4'b0001;						// sub for branch
		  rom[7'b01_110_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_110_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_110_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_110_1_1] = 4'b0001;						// sub for branch
		  rom[7'b01_111_0_0] = 4'b0001;						// sub for branch
		  rom[7'b01_111_0_1] = 4'b0001;						// sub for branch
		  rom[7'b01_111_1_0] = 4'b0001;						// sub for branch
		  rom[7'b01_111_1_1] = 4'b0001;						// sub for branch
		  
		  //10
		  rom[7'b10_000_0_0] = 4'b0000; 						// addi
		  rom[7'b10_000_0_1] = 4'b0000; 						// addi
		  
		  rom[7'b10_000_1_0] = 4'b0000; 						// add
		  rom[7'b10_000_1_1] = 4'b0001; 						// sub
		  
		  rom[7'b10_001_1_0] = 4'b0110; 						// sll
		  rom[7'b10_001_1_1] = 4'b0000; 						// instruction error
		  
		  rom[7'b10_001_0_0] = 4'b0110; 						// slli
		  rom[7'b10_001_0_1] = 4'b0110; 						// slli, this cannot be happen also, but if some one give immediate greater than 32 funct75 can be 1.
																		// therefore to compensate that user error we give the same operation 0101 for that.
		  
		  rom[7'b10_010_1_0] = 4'b0101; 						// slt
		  rom[7'b10_010_1_1] = 4'b0000; 						// instruction error
		  
		  rom[7'b10_010_0_0] = 4'b0101; 						// slti
		  rom[7'b10_010_0_1] = 4'b0101; 						// slti
		  
		  rom[7'b10_011_1_0] = 4'b1001; 						// sltu
		  rom[7'b10_011_1_1] = 4'b0000; 						// instruction error
		  
		  rom[7'b10_011_0_0] = 4'b1001; 						// sltiu
		  rom[7'b10_011_0_1] = 4'b1001; 						// sltiu
		  
		  rom[7'b10_100_1_0] = 4'b0100; 						// xor
		  rom[7'b10_100_1_1] = 4'b0000; 						// instruction error
		  
		  rom[7'b10_100_0_0] = 4'b0100; 						// xori
		  rom[7'b10_100_0_1] = 4'b0100; 						// xori
		  
		  rom[7'b10_101_1_0] = 4'b0111; 						// srl
		  rom[7'b10_101_0_0] = 4'b0111; 						// srli
		  
		  rom[7'b10_101_1_1] = 4'b1000; 						// sra
		  rom[7'b10_101_0_1] = 4'b1000; 						// srai
		  
		  rom[7'b10_110_1_0] = 4'b0011; 						// or
		  rom[7'b10_110_1_1] = 4'b0000; 						// instruction error
		  
		  rom[7'b10_110_0_0] = 4'b0011; 						// ori
		  rom[7'b10_110_0_1] = 4'b0011; 						// ori
		  
		  rom[7'b10_111_1_0] = 4'b0010; 						// and 
		  rom[7'b10_111_1_1] = 4'b0000; 						// instruction error
		  
		  rom[7'b10_111_0_0] = 4'b0010; 						// andi 
		  rom[7'b10_111_0_1] = 4'b0010; 						// andi 
		  
		  
    end

    // Read from the ROM based on the opcode
    assign ALUControl = rom[addr];
	 
endmodule

/*for memories some times putting 'x' on address side, wont work. there for you have to specify exactly what is x is in address side.
	dont know about the data side i.e rom[address] bits*/