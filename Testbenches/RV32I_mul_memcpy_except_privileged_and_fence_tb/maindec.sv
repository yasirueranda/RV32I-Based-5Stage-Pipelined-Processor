module maindec(input logic [6:0] op,
					output logic RegWrite,
               output logic ALUSrc,
					output logic Branch,
					output logic [2:0] immSrc,
               output logic [1:0] ALUOp,
					output logic memwrite1,memwrite2,
					output logic [1:0] wdsel,
					output logic jump,
					output logic jumpsel,
					output logic [1:0] resultsrc);

    // Declare a ROM with 2^7 (128) entries and 11 bits per entry
    reg [15:0] rom [0:127];

    // Initialize the ROM with control signal values
    initial begin
        // Initialize the ROM based on opcode
        rom[7'b0110011] = 16'b0_10_1_0_xxx_00_00_0_00_x; // R-type
        rom[7'b0010011] = 16'b1_10_1_0_000_00_00_0_00_x; // I-type ALU
		  rom[7'b1100011] = 16'b0_01_0_1_001_00_xx_0_xx_0; // Branch instructions
		  rom[7'b0000011] = 16'b1_00_1_0_000_00_01_0_01_x; // Load
		  rom[7'b0100011] = 16'b1_00_0_0_010_10_xx_0_xx_x; // Store
		  rom[7'b1101111] = 16'bx_xx_1_x_011_00_00_1_10_0; // Jal
		  rom[7'b1100111] = 16'bx_xx_1_x_000_00_00_1_10_1; // Jalr
		  rom[7'b0110111] = 16'bx_xx_1_0_100_00_10_0_xx_x; // lui
		  rom[7'b0010111] = 16'bx_xx_1_0_100_00_11_0_xx_0; // auipc
		  rom[7'b1000011] = 16'b1_00_0_0_010_01_xx_0_xx_x; // memcopy
        // Add more opcode entries as needed
    end

    // Read from the ROM based on the opcode
    assign {ALUSrc,ALUOp,RegWrite,Branch,immSrc,memwrite1,memwrite2,wdsel,jump,resultsrc,jumpsel} = rom[op];

endmodule

/*for memories some times putting 'x' on address side wont work. there for you have to specify exactly what is x is in address side
	i dont about the data side i.e rom[address] bits*/