module maindec(input logic [6:0] op,
					output logic RegWrite,
               output logic ALUSrc,
					output logic [2:0] immSrc,
               output logic [1:0] ALUOp,
					output logic memwrite,
					output logic [1:0] wdsel,
					output logic [1:0] resultsrc,
					output logic jumpsel);

    // Declare a ROM with 2^7 (128) entries and 11 bits per entry
    reg [12:0] rom [0:127];

    // Initialize the ROM with control signal values
    initial begin
        // Initialize the ROM based on opcode
        rom[7'b0110011] = 13'b0_10_1_xxx_0_00_00_x; // R-type
        rom[7'b0010011] = 13'b1_10_1_000_0_00_00_x; // I-type ALU
		  rom[7'b0000011] = 13'b1_00_1_000_0_01_01_x; // Load
		  rom[7'b0100011] = 13'b1_00_0_010_1_xx_xx_x; // Store
		  rom[7'b0110111] = 13'b1_00_0_100_1_10_xx_x; // lui
		  rom[7'b0010111] = 13'b1_00_0_100_1_11_xx_0; // auipc
        // Add more opcode entries as needed
    end

    // Read from the ROM based on the opcode
    assign {ALUSrc,ALUOp,RegWrite,immSrc,memwrite,wdsel,resultsrc,jumpsel} = rom[op];

endmodule

/*for memories some times putting 'x' on address side wont work. there for you have to specify exactly what is x is in address side
	i dont about the data side i.e rom[address] bits*/	
	/*	  rom[7'b0110011] = 15'b0_10_1_0_xxx_0_00_0_00_x; // R-type
        rom[7'b0010011] = 15'b1_10_1_0_000_0_00_0_00_x; // I-type ALU
		  rom[7'b1100011] = 15'b0_01_0_1_001_0_xx_0_xx_0; // Branch instructions
		  rom[7'b0000011] = 15'b1_00_1_0_000_0_01_0_01_x; // Load
		  rom[7'b0100011] = 15'b1_00_0_0_010_1_xx_0_xx_x; // Store
		  rom[7'b1101111] = 15'bx_xx_1_x_011_0_00_1_10_0; // Jal
		  rom[7'b1100111] = 15'bx_xx_1_x_000_0_00_1_10_1; // Jalr
		  rom[7'b0110111] = 15'bx_xx_1_0_100_0_10_0_xx_x; // lui
		  rom[7'b0010111] = 15'bx_xx_1_0_100_0_11_0_xx_0; // auipc  */