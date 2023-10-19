module regfile(
    input logic clk,reset,
    input logic we3,
    input logic [4:0] a1, a2, a3,
    input logic [31:0] wd3,
    output logic [31:0] rd1, rd2
);

    logic [31:0] rf [31:0];
	 
	 integer i;
	 
	 //************************************************************************************************************************************
	 /*
    // Initialize specific registers with values
    initial begin
        // Initialize register at index 5 with the value 456
        rf[1] = 32'h0000_0008;
		  rf[2] = 32'h0000_0009;
		  rf[3] = 32'hAAAA_AAAA;
		  rf[4] = 32'h5555_5555;

        // You can add more initializations as needed
    end
	 */
	 //*************************this initialisation of values cause compitlation error when it comes to simulating*************************

    // Three-ported register file
    // Read two ports combinationally (A1/RD1, A2/RD2)
    // Write the third port on the rising edge of the clock (A3/WD3/WE3)
    always_ff @(posedge clk,posedge reset) begin
		if (reset==1'b1)
			for (i = 0; i < 32; i = i + 1)
				rf[i] <= 0;
		else if(reset==1'b0 && we3==1'b1)
			rf[a3] <= wd3;
	 end

    assign rd1 = (a1 != 0) ? rf[a1] : 0;
    assign rd2 = (a2 != 0) ? rf[a2] : 0;

endmodule