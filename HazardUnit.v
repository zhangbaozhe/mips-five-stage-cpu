/* 
 * File Name: HazardUnit.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file implements the hazard detection unit of 
 * the five-stage MIPS CPU.
 * 
 * For example, (1)
 *      lw  $2,     20($1)
 *          ^^
 *      and $4,     $2, $5
 *                  ^^
 *      or  $8,     $2, $6      
 *                  ^^
 * such a combination of commands will cause another kind of 
 * data hazard which forwarding cannot handle. Thus, we have to
 * stall the pipeline. 
 * Besides, there are two other types of stall to be handled.
 *      add $1,     $2, $3
 *      # 1-cycle (or 2-cycle) stall (2)
 *      beq $1,     $2, address
 * 
 *      lw  $1,     20($2)
 *      # 2-cycle stall (3)
 *      beq $1,     $2, address
 * In addition, for JR instructions, the implementation is much similar, 
 * e.g., there will be a 2-cycle(or 1-cycle) stall between the possible instructions.
 * Then a forwarding will take place.
 *
 *
 */

`ifndef _HAZARD_UNIT
`define _HAZARD_UNIT

module HazardUnit (
    input               ID_EX_MemRead, 
    input               EX_MEM_MemRead, 
    input [1:0]         Branch,
    input               Delay,  
    input [4:0]         ID_EX_RegisterRd, /* (regdst) ? rt : rd */ 
    input [4:0]         EX_MEM_RegisterRd, 
    input [4:0]         IF_ID_RegisterRs, 
    input [4:0]         IF_ID_RegisterRt, 
    output reg          PCWrite, 
    output reg          IF_ID_Write, 
    output reg          Stall
);

    wire                ID_EX_MemRead;
    wire                EX_MEM_MemRead;
    wire [1:0]          Branch;
    wire                Delay;
    wire [4:0]          ID_EX_RegisterRd;
    // wire [4:0]          ID_EX_RegisterRt;
    wire [4:0]          EX_MEM_RegisterRd;
    wire [4:0]          IF_ID_RegisterRs;
    wire [4:0]          IF_ID_RegisterRt;

    initial begin
        PCWrite = 1;
        IF_ID_Write = 1;
        Stall = 0;
    end

    always @(*) begin
        /* this handles (1) and one cycle in (3) */
        if (ID_EX_MemRead 
            && ((ID_EX_RegisterRd == IF_ID_RegisterRs)
                || (ID_EX_RegisterRd == IF_ID_RegisterRt)))
        begin
            PCWrite = 0;
            IF_ID_Write = 0;
            Stall = 1;
        end
        /* this handles (2) */
        else if ((Branch == 2'b10 || Branch == 2'b01) 
                && ((ID_EX_RegisterRd == IF_ID_RegisterRs)
                    || (ID_EX_RegisterRd == IF_ID_RegisterRt)))
        begin
            PCWrite = 0;
            IF_ID_Write = 0;
            Stall = 1;
        end
        /* this handles the second cycle in (3) */
        else if ((Branch == 2'b10 || Branch == 2'b01) 
                && ((EX_MEM_RegisterRd == IF_ID_RegisterRs)
                    || (EX_MEM_RegisterRd == IF_ID_RegisterRt))) 
        begin
            PCWrite = 0;
            IF_ID_Write = 0;
            Stall = 1;
        end
        else if ((Branch == 2'b11)
                && (ID_EX_RegisterRd == IF_ID_RegisterRs))
        begin
            PCWrite = 0;
            IF_ID_Write = 0;
            Stall = 1;
        end
        /* another stall for lw before branching */
        else if ((Branch == 2'b11) && EX_MEM_MemRead
                && (EX_MEM_RegisterRd == IF_ID_RegisterRs))
        begin
            PCWrite = 0;
            IF_ID_Write = 0;
            Stall = 1;
        end
        else begin
            PCWrite = 1;
            IF_ID_Write = 1;
            Stall = 0;
        end
        if (Delay) 
            Stall = 1;
    end

endmodule 

`endif
/* TODO: 
    The if logic may cause some trouble 
    e.g. 
    xxx(not r-type) $1, xxx, xxx
    beq             $1, xxx, xxx
 */