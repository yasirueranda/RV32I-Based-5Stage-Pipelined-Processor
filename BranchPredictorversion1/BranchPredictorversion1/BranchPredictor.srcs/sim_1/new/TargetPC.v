`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2023 12:29:50 PM
// Design Name: 
// Module Name: TargetPC
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


module TargetPC(
    input wire [31:0] Target_PC_ID,
    input wire missPrediction,
    input wire reset,
    input wire clk,
    output reg [31:0] Target_PC

    );
    reg [31:0] Target_PC_prev;
    always@(Target_PC_prev , Target_PC_ID,reset, missPrediction)begin
    if (reset) begin 
        Target_PC<=32'b0;
    end 
    else begin
        if (missPrediction) begin
           Target_PC<= Target_PC_prev;
        end 
        else begin
            Target_PC<=Target_PC_ID;
        end 
    end 
   end 
   
   
   always@(negedge clk or negedge reset) begin
        if (reset) begin 
            Target_PC_prev<=32'b0;
        end else begin
            Target_PC_prev<=Target_PC_ID;
        end 
   end 
endmodule
