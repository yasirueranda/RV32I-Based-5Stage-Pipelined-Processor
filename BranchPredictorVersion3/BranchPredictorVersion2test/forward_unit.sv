module forward_unit(input wire regwrite_wb,regwrite_mem,
							 input wire [4:0] rs1_addr_ex,rs2_addr_ex,
							 input wire [4:0] regwrite_addr_MEM,regwrite_addr_WB,
							 output wire [1:0] control_1,control_2);
	
	always_comb begin
        if ((rs1_addr_ex == regwrite_addr_MEM) && regwrite_mem && (rs1_addr_ex != 5'b00000))
            control_1 = 2'b10;
        else if ((rs1_addr_ex == regwrite_addr_WB) && regwrite_wb && (rs1_addr_ex != 5'b00000))
            control_1 = 2'b01;
        else
            control_1 = 2'b00;

        if ((rs2_addr_ex == regwrite_addr_MEM) && regwrite_mem && (rs2_addr_ex != 5'b00000))
            control_2 = 2'b10;
        else if ((rs2_addr_ex == regwrite_addr_WB) && regwrite_wb && (rs2_addr_ex != 5'b00000))
            control_2 = 2'b01;
        else
            control_2 = 2'b00;
    end
	
endmodule

//logic
/*
if ((rs1_addr_ex==regwrite_addr_mem)&regwrite_mem) &(rs1_addr_ex!=5'b00000) then
	control_1=2'b10
else if ((rs1_addr_ex==regwrite_addr_wb)&regwrite_wb) &(rs1_addr_ex!=5'b00000) then
	control_1=2'b01
else 
	control_1=2'b00
*/
	