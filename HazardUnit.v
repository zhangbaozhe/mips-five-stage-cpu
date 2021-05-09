/* 
 * File Name: ControlUnit.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file contains the implementation of the 
 * control unit in the CPU.
 * 
 */

module ControlUnit (
    input [31:0] instruction, 
    input stall, 
    output reg MemtoReg, 
    output reg RegWrite, 
    output reg MemWrite, 
    output reg MemRead, 
    output reg Branch, 
    output reg [3:0] ALUControl, 
    output reg ALUSrc, 
    output reg RegDst
); 


endmodule