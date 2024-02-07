`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2023 09:25:21 AM
// Design Name: 
// Module Name: TopTB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TopTB();
reg reset,clk;
reg [5:0] selm;
wire [3:0] flags_EX;
reg [6:0] hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0;
localparam CLK_PERIOD = 10; // Clock period in simulation ticks
top Top(reset ,clk,flags_EX,selm,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0);
 always #((CLK_PERIOD / 2)) clk = ~clk;
 initial begin
    clk=0;
    #10 reset=0;
    #20 reset=1;
    
end 
    
endmodule
