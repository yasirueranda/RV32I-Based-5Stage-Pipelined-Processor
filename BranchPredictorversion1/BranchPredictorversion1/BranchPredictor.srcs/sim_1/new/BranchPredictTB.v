`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2023 05:22:40 AM
// Design Name: 
// Module Name: BranchPredictTB
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


module BranchPredictTB();




    // Constants
    localparam CLK_PERIOD = 10; // Clock period in simulation ticks

    // Signals
    reg clk;
    reg reset;
    reg branch_instruction_valid;
    reg [31:0] branch_instruction_address;
    reg actual_branch_outcome;
    wire branch_prediction;
    wire flash_pipeline;

    // Instantiate the DUT (Design Under Test)
    BranchPredictor predictor (
        .clk(clk),
        .reset(reset),
        .branch_instruction_valid(branch_instruction_valid),
        .branch_instruction_address(branch_instruction_address),
        .actual_branch_outcome(actual_branch_outcome),
        .branch_prediction(branch_prediction),
        .flash_pipeline(flash_pipeline)
    );

    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;

    // Initial conditions
    initial begin
        clk = 0;
        reset = 1;
        branch_instruction_valid = 0;
        branch_instruction_address = 0;
        actual_branch_outcome = 0;
        #10 reset = 0; // Release reset after 10 ticks
        #5;
        // Test case 1: Correct prediction (branch not taken)
        #20 branch_instruction_valid = 1;
        branch_instruction_address = 32; // Sample branch address
        #10;
       
        branch_instruction_valid = 1;
        branch_instruction_address = 36; 
        #2  actual_branch_outcome = 1; // Branch not taken
        
        #4;
//        if (branch_prediction === 0 && flash_pipeline === 0) begin
//            $display("Test case 1: Passed - Correctly predicted branch not taken");
//        end else begin
//            $display("Test case 1: Failed");
//        end

//        // Test case 2: Misprediction (branch taken)
//        #20 branch_instruction_valid = 1;
//        branch_instruction_address = 32; // Sample branch address
//        actual_branch_outcome = 1; // Branch taken
//        #10; // Wait for prediction to settle
//        if (branch_prediction === 1 && flash_pipeline === 1) begin
//            $display("Test case 2: Passed - Mispredicted taken branch");
//        end else begin
//            $display("Test case 2: Failed");
//        end

        // Add more test cases as needed...

        // End simulation
        #10;
        $finish;
    end



    
endmodule
