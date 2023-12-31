`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2023 07:45:36 AM
// Design Name: 
// Module Name: PredictorSel
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


module PredictorSel(
    input PredictionIn,
    input PredictionPrev2,
    input misprediction,
    output PredictionOut
    );
    reg Prediction;
    always@(*)begin
        if (misprediction ) Prediction <=~PredictionPrev2 ;
        else Prediction <=PredictionIn ;
    end 
    assign PredictionOut =Prediction ;
endmodule
