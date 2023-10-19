module maindec(input logic [6:0] op,
					output logic RegWrite,
               output logic ALUSrc,
					output logic Branch,
					output logic immSrc,
               output logic [1:0] ALUOp);

    // Declare a ROM with 2^7 (128) entries and 11 bits per entry
    reg [5:0] rom [0:127];

    // Initialize the ROM with control signal values
    initial begin
        // Initialize the ROM based on opcode
        // Format: rom[opcode] = {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump}
        // For example:
        rom[7'b0110011] = 6'b0_10_1_0_0; // R-type
        rom[7'b0010011] = 6'b0_10_1_0_0; // I-type ALU
		  rom[7'b1100011] = 6'b1_01_0_1_1; // Branch instructions
        // Add more opcode entries as needed
    end

    // Read from the ROM based on the opcode
    assign {ALUSrc,ALUOp,RegWrite,Branch,immSrc} = rom[op];

endmodule