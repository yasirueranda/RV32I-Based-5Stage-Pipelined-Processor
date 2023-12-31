`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2023 12:30:47 PM
// Design Name: 
// Module Name: PC_4
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


module PC_4(
    input wire [31:0] PC_4_IF,
    input wire missPrediction,
    input wire reset,
    input wire clk,
    output reg [31:0] PC4

    );
    reg [31:0] PC_4_IF_prev;
    reg [31:0] PC_4_IF_prev2;
    
    always@(PC_4_IF_prev2 , PC_4_IF,reset, missPrediction)begin
    if (~reset) begin 
        PC4<=32'b0;
    end 
    else begin
        if (missPrediction) begin
           PC4<= PC_4_IF_prev2;
        end 
        else begin
            PC4<=PC_4_IF;
        end 
    end 
   end 
   
   
   always@(negedge clk or negedge reset) begin
        if (~reset) begin 
            PC_4_IF_prev<=32'b0;
            PC_4_IF_prev2<=32'b0;
        end else begin
            PC_4_IF_prev<=PC_4_IF;
            PC_4_IF_prev2<=PC_4_IF_prev;
        end 
   end 
endmodule