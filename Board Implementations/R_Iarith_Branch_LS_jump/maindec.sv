module maindec(input logic [6:0] op,
					output logic RegWrite,
               output logic ALUSrc,
					output logic Branch,
					output logic [1:0] immSrc,
               output logic [1:0] ALUOp,
					output logic memwrite,
					output logic wdsel,
					output logic jump,
					output logic [1:0] resultsrc);

    // Declare a ROM with 2^7 (128) entries and 11 bits per entry
    reg [11:0] rom [0:127];

    // Initialize the ROM with control signal values
    initial begin
        // Initialize the ROM based on opcode
        rom[7'b0110011] = 12'b0_10_1_0_00_0_0_0_00; // R-type
        rom[7'b0010011] = 12'b1_10_1_0_00_0_0_0_00; // I-type ALU
		  rom[7'b1100011] = 12'b0_01_0_1_01_0_0_0_00; // Branch instructions
		  rom[7'b0000011] = 12'b1_00_1_0_00_0_1_0_01; // Load
		  rom[7'b0100011] = 12'b1_00_0_0_10_1_x_0_xx; // Store
		  rom[7'b1101111] = 12'bx_xx_1_0_11_0_x_1_10; // Jal
        // Add more opcode entries as needed
    end

    // Read from the ROM based on the opcode
    assign {ALUSrc,ALUOp,RegWrite,Branch,immSrc,memwrite,wdsel,jump,resultsrc} = rom[op];

endmodule

/*for memories some times putting 'x' on address side wont work. there for you have to specify exactly what is x is in address side
	i dont about the data side i.e rom[address] bits*/