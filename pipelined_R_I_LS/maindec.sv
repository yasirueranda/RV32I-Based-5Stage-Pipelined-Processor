module maindec(input logic [6:0] op,
					output logic RegWrite,
               output logic ALUSrc,
					output logic immSrc,
               output logic [1:0] ALUOp,
					output logic memwrite,
					output logic wdsel,
					output logic resultsrc);

    // Declare a ROM with 2^7 (128) entries and 11 bits per entry
    reg [7:0] rom [0:127];

    // Initialize the ROM with control signal values
    initial begin
        // Initialize the ROM based on opcode
        rom[7'b0110011] = 8'b0_10_1_x_0_0_0; // R-type
        rom[7'b0010011] = 8'b1_10_1_0_0_0_0; // I-type ALU
		  rom[7'b0000011] = 8'b1_00_1_0_0_1_1; // Load
		  rom[7'b0100011] = 8'b1_00_0_1_1_x_x; // Store
		  rom[7'b0110111] = 8'b1_00_0_1_1_x_x; // LUI
		  rom[7'b0010111] = 8'b1_00_0_1_1_x_x; // AUIPC
        // Add more opcode entries as needed
    end

    // Read from the ROM based on the opcode
    assign {ALUSrc,ALUOp,RegWrite,immSrc,memwrite,wdsel,resultsrc} = rom[op];

endmodule

/*for memories some times putting 'x' on address side wont work. there for you have to specify exactly what is x is in address side
	i dont about the data side i.e rom[address] bits*/