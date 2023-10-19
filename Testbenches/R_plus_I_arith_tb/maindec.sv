module maindec(input logic [6:0] op,
					output logic RegWrite,
               output logic ALUSrc,
               output logic [1:0] ALUOp);

    // Declare a ROM with 2^7 (128) entries and 11 bits per entry
    reg [4:0] rom [0:127];

    // Initialize the ROM with control signal values
    initial begin
        // Initialize the ROM based on opcode
        // Format: rom[opcode] = {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump}
        // For example:
        rom[7'b0110011] = 3'b1_10_1; // R-type
        rom[7'b0010011] = 3'b0_10_1; // I-type ALU
        // Add more opcode entries as needed
    end

    // Read from the ROM based on the opcode
    assign {ALUSrc,ALUOp,RegWrite} = rom[op];

endmodule