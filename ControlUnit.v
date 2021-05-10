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
    output reg [1:0] Branch, 
    output reg [3:0] ALUControl, 
    output reg ALUSrc, 
    output reg RegDst
); 
/* 
 * Implementation notes:
 * ---------------------
 * Support instructions:
 *      lw, sw, add, sub, 
 *      and, or, beq, slt, 
 * 
 * -----------------------
 * Branch:
 *      00 -> not branching
 *      10 -> bne
 *      01 -> beq 
 *
 * ALUSrc:
 *      0 -> readData2 (from register file)
 *      1 -> immediage number (from sign-extension)
 *
 * RedDst:
 *      0 -> normal rd (for R-type instructions)
 *      1 -> rt (for some other load/store instructions)
 */ 

wire [31:0] instruction;
wire stall;

always @(*) begin
    if (stall) begin 
        MemtoReg = 0;
        RegWrite = 0;
        MemWrite = 0;
        MemRead = 0;
        Branch = 2'b00;
        ALUControl = 4'b1111; /* no such control */
        ALUSrc = 0;
        RegDst = 0;
    end
    else begin
        case (instruction[31:26])
            6'b000000: begin
                case (instruction[5:0]) 
                    /* add */
                    6'h20: begin
                        MemtoReg = 0;
                        RegWrite = 1;
                        MemWrite = 0;
                        MemRead = 0;
                        Branch = 2'b00;
                        ALUControl = 4'b0010; 
                        ALUSrc = 0;
                        RegDst = 0;
                    end

                    /* and */
                    6'h24: begin
                        MemtoReg = 0;
                        RegWrite = 1;
                        MemWrite = 0;
                        MemRead = 0;
                        Branch = 2'b00;
                        ALUControl = 4'b0000; 
                        ALUSrc = 0;
                        RegDst = 0;
                    end

                    /* or */
                    6'h25: begin
                        MemtoReg = 0;
                        RegWrite = 1;
                        MemWrite = 0;
                        MemRead = 0;
                        Branch = 2'b00;
                        ALUControl = 4'b0001; 
                        ALUSrc = 0;
                        RegDst = 0;
                        
                    end

                    /* sub */
                    6'h22: begin
                        MemtoReg = 0;
                        RegWrite = 1;
                        MemWrite = 0;
                        MemRead = 0;
                        Branch = 2'b00;
                        ALUControl = 4'b0110; 
                        ALUSrc = 0;
                        RegDst = 0;
                        
                    end

                    /* slt */
                    6'h2a: begin
                        MemtoReg = 0;
                        RegWrite = 1;
                        MemWrite = 0;
                        MemRead = 0;
                        Branch = 2'b00;
                        ALUControl = 4'b0000; 
                        ALUSrc = 0;
                        RegDst = 0;
                        
                    end
                endcase
            end

            /* beq */
            6'h4: begin
                MemtoReg = 0;
                RegWrite = 0;
                MemWrite = 0;
                MemRead = 0;
                Branch = 2'b01;
                ALUControl = 4'b0110; 
                ALUSrc = 0;
                RegDst = 0;
                
            end

            /* lw */
            6'h23: begin
                MemtoReg = 1;
                RegWrite = 1;
                MemWrite = 0;
                MemRead = 1;
                Branch = 2'b00;
                ALUControl = 4'b0010; 
                ALUSrc = 1; /* rs field should be 00000 */
                RegDst = 1;
                
            end

            /* sw */
            6'h2b: begin
                MemtoReg = 0;
                RegWrite = 0;
                MemWrite = 1;
                MemRead = 1;
                Branch = 2'b00;
                ALUControl = 4'b0010;
                ALUSrc = 1; /* rs field should be 00000 */
                RegDst = 1;
                
            end
        endcase
    end
end

endmodule