/* 
 * File Name: BranchUnit.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file contains the implementation of the 
 * branch unit in the CPU.
 * ----------------------------
 * Additional comments:
 * This file attempts to put the whole branch from MEM stage to ID stage
 * to lessen the branch-related hazards according to the textbook.
 * This is the unit trying to detect whether a branch is occurred.
 * 
 * One big problem for this implementation is to handle such hazard e.g.,
 *      slt reg1, reg2, reg3
 *      beq reg1, zero, LABEL
 * Since now the branch is no longer in the MEM stage, 
 * there will be a data hazard about reg1. 
 * Basically, some stalls will save situations like this, which 
 * will be controled in the hazard unit. 
 */
 
`ifndef _BRANCH_UNIT
`define _BRANCH_UNIT

module BranchUnit (
    input [1:0]         Branch, 
    input               zero, 
    output reg          PCSrc
);

    initial begin
        PCSrc = 0;
    end
    always @(*) begin
        case (Branch) 
            /* not branch */
            2'b00: begin
                PCSrc <= 1'b0;
            end
            /* beq */
            2'b01: begin
                PCSrc <= zero;
            end
            /* bne */
            2'b10: begin
                PCSrc <= !zero;
            end
        endcase
        // PCSrc = 1'b0;
    end

endmodule

module BranchDelay (
    input [1:0]         ID_EX_Branch, 
    input               ID_EX_PCSrc, 
    output reg          Delay
);
    wire [1:0]          ID_EX_Branch; 
    wire                ID_EX_PCSrc;
    always @(*) begin
        if (ID_EX_Branch != 2'b00 && ID_EX_PCSrc)
            Delay = 1'b1;
        else
            Delay = 1'b0;
    end
endmodule

`endif