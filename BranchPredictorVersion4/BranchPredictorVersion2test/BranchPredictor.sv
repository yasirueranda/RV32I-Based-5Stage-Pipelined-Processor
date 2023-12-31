`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2023 02:43:49 AM
// Design Name: 
// Module Name: BranchPredictor
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


module BranchPredictor(
    input wire clk,
    input wire reset,
    input wire branch_instruction_valid,
    input wire [31:0] branch_instruction_address,
    input wire actual_branch_outcome,
    output reg branch_prediction,
    output wire flash_pipeline
);

    // Define parameters
    parameter TABLE_SIZE = 32; // Number of entries in the predictor table. Can store state histories of 32 different branch addresses

    // Define state variables
    reg [1:0] predictor_table [0:TABLE_SIZE-1];
    reg [4:0] history_index;
    reg misprediction;
    reg [4:0] delayed_history_index; // To store the delayed branch instruction address index
    reg delayed_branch_prediction; // To store the delayed branch prediction
    reg delayed_branch_valid;
    reg [4:0] delayed_history_index2; // To store the delayed branch instruction address index
    reg delayed_branch_prediction2; // To store the delayed branch prediction
    reg delayed_branch_valid2;
    
   
always@(negedge clk or negedge reset) begin
    if (~reset) begin
            delayed_branch_valid <=1'b0;
            delayed_history_index <= 1'b0;
            delayed_branch_prediction <= 1'b0;
            delayed_branch_valid2 <=1'b0;
            delayed_history_index2 <= 1'b0;
            delayed_branch_prediction2 <= 1'b0;
    end 
    else begin
            delayed_branch_valid <=branch_instruction_valid;
            delayed_history_index <= history_index;
            delayed_branch_prediction <= branch_prediction;
            delayed_branch_valid2 <= delayed_branch_valid;
            delayed_history_index2 <= delayed_history_index;
            delayed_branch_prediction2 <= delayed_branch_prediction;
    end 
end 
    // initialize when reset is 1 
    always @(delayed_branch_valid2,delayed_branch_prediction2, reset,delayed_history_index2,actual_branch_outcome) begin
        if (~reset) begin
            
            misprediction <= 0;
            
            // Reset predictor table entries to Weakly Not Taken (2'b01)
            predictor_table[0] <= 2'b01;
            predictor_table[1] <= 2'b01;
            predictor_table[2] <= 2'b01;
            predictor_table[3] <= 2'b01;
            predictor_table[4] <= 2'b01;
            predictor_table[5] <= 2'b01;
            predictor_table[6] <= 2'b01;
            predictor_table[7] <= 2'b01;
            predictor_table[8] <= 2'b01;
            predictor_table[9] <= 2'b01;
            predictor_table[10] <= 2'b01;
            predictor_table[11] <= 2'b01;
            predictor_table[12] <= 2'b01;
            predictor_table[13] <= 2'b01;
            predictor_table[14] <= 2'b01;
            predictor_table[15] <= 2'b01;
            predictor_table[16] <= 2'b01;
            predictor_table[17] <= 2'b01;
            predictor_table[18] <= 2'b01;
            predictor_table[19] <= 2'b01;
            predictor_table[20] <= 2'b01;
            predictor_table[21] <= 2'b01;
            predictor_table[22] <= 2'b01;
            predictor_table[23] <= 2'b01;
            predictor_table[24] <= 2'b01;
            predictor_table[25] <= 2'b01;
            predictor_table[26] <= 2'b01;
            predictor_table[27] <= 2'b01;
            predictor_table[28] <= 2'b01;
            predictor_table[29] <= 2'b01;
            predictor_table[30] <= 2'b01;
            predictor_table[31] <= 2'b01;
            
        end else begin
           
            // Update mechanism
            if (branch_instruction_valid) begin
                if (actual_branch_outcome == delayed_branch_prediction2) begin
                    // Prediction was correct, don't change the counter
                    misprediction <= 0;
                end else begin
                    // Prediction was incorrect
                    misprediction <= 1;
                    // Branch was taken but predicted not taken: increment counter
                    if (actual_branch_outcome) begin
                        if (predictor_table[delayed_history_index2] < 2'b11) begin
                            predictor_table[delayed_history_index2] <= predictor_table[delayed_history_index2] + 1;
                        end
                        else begin 
                            predictor_table[delayed_history_index2] <= predictor_table[delayed_history_index2];
                        end 
                    // Branch was not taken but predicted taken: decrement counter
                    end else begin
                        if (predictor_table[delayed_history_index2] > 2'b00) begin
                            predictor_table[delayed_history_index2] <= predictor_table[delayed_history_index2] - 1;
                        end
                        else begin
                            predictor_table[delayed_history_index2] <= predictor_table[delayed_history_index2];
                        end 
                    end
                end
            end
        end
    end
    
    always@(branch_instruction_address,reset)
    begin
    if (~reset) begin 
        history_index <= 0;
        branch_prediction<=1'b0;
    end 
    else begin
            // Update history index based on branch instruction address
            history_index <= branch_instruction_address % TABLE_SIZE;
            
            // Prediction mechanism
            if (branch_instruction_valid) begin
                if (predictor_table[history_index] >= 2'b10) begin
                    // Strongly Taken or Weakly Taken: predict taken
                    branch_prediction <= 1'b1;
                end else begin
                    // Strongly Not Taken or Weakly Not Taken: predict not taken
                    branch_prediction <= 1'b0;
                end 
            end else begin
                 branch_prediction <= 1'b0;
            end 
    end 
    end 
    // Flash control output-ID not sure about EX
    assign flash_pipeline = misprediction;

endmodule