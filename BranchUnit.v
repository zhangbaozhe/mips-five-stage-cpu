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

module BranchUnit (
    input [1:0] Branch, 
    input zero, 
    output reg PCSrc
);

always @(*) begin
    if (Branch != 2'b00)
    begin
        if (zero == 1)
            PCSrc = 1;
        else 
            PCSrc = 0;
    end
    else 
        PCSrc = 0;
end

endmodule