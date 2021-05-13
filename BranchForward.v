/* 
 * File Name: BranchForward.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file contains the implementation of the 
 * branch forwarding unit in the CPU. It is based on the fact
 * that the branching is in the ID stage and that the control unit 
 * will proper stall when encourter commands such as:
 *      add $1, $2, $3
 *      # 1 stall
 *      beq $1, $2, address
 * OR
 *      lw  $1, 8($s2)
 *      # 2 stalls
 *      beq $1, $2, address
 * 
 */

`ifndef _BRANCH_FORWARD
`define _BRANCH_FORWARD

module BranchForward (
    input [1:0]         Branch, 
    input [4:0]         EX_MEM_RegisterRd, 
    input [4:0]         MEM_WB_RegisterRd, 
    input [4:0]         IF_ID_RegisterRs, 
    input [4:0]         IF_ID_RegisterRt, 
    output reg [1:0]    BranchForwardA, 
    output reg [1:0]    BranchForwardB
);

always @(*) begin
    /* EX hazard */
    if ((Branch != 2'b00)
        && (EX_MEM_RegisterRd == IF_ID_RegisterRs)
        && (EX_MEM_RegisterRd != 5'b00000))
        begin
            BranchForwardA <= 2'b10;
            BranchForwardB <= 2'b00;
        end

    else if ((Branch != 2'b00)
        && (EX_MEM_RegisterRd == IF_ID_RegisterRt)
        && (EX_MEM_RegisterRd != 5'b00000))
        begin
            BranchForwardA <= 2'b00;
            BranchForwardB <= 2'b10;
        end

    /* MEM hazard */
    else if ((Branch != 2'b00)
        && (MEM_WB_RegisterRd == IF_ID_RegisterRs)
        && (MEM_WB_RegisterRd != 5'b00000))
        begin
            BranchForwardA <= 2'b01;
            BranchForwardB <= 2'b00;
        end

    else if ((Branch != 2'b00)
        && (MEM_WB_RegisterRd == IF_ID_RegisterRt)
        && (MEM_WB_RegisterRd != 5'b00000))
        begin
            BranchForwardA <= 2'b00;
            BranchForwardB <= 2'b01;
        end

    else begin
        BranchForwardA <= 2'b00;
        BranchForwardB <= 2'b00;
    end
end

endmodule
`endif