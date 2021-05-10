/* 
 * File Name: HazardUnit.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file implements the hazard detection unit of 
 * the five-stage MIPS CPU.
 * 
 * For example, 
 *      lw  $2,     20($1)
 *          ^^
 *      and $4,     $2, $5
 *                  ^^
 *      or  $8,     $2, $6      
 *                  ^^
 * such a combination of commands will cause another kind of 
 * data hazard which forwarding cannot handle. Thus, we have to
 * stall the pipeline. 
 * 
 */

module HazardUnit (
    input ID_EX_MemRead, 
    input [4:0] ID_EX_RegisterRt, 
    input [4:0] IF_ID_RegisterRs, 
    input [4:0] IF_ID_RegisterRt, 
    output reg PCWrite, 
    output reg IF_ID_Write
);

wire ID_EX_MemRead;
wire [4:0] ID_EX_RegisterRt;
wire [4:0] IF_ID_RegisterRs;
wire [4:0] IF_ID_RegisterRt;

always @(*) begin
    if (ID_EX_MemRead 
        and ((ID_EX_RegisterRt == IF_ID_RegisterRs)
             or (ID_EX_RegisterRt == IF_ID_RegisterRt)))
    begin
        PCWrite = 0;
        IF_ID_Write = 0;
    end
end

endmodule 