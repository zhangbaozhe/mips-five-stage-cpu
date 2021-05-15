/* 
 * File Name: ControlUnit.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file contains the implementation of the 
 * control unit in the CPU.
 * 
 */

`ifndef _CONTROL_UNIT
`define _CONTROL_UNIT

module ControlUnit (
    input [31:0]        instruction, 
    // input               stall, 
    output reg          MemtoReg, 
    output reg          RegWrite, 
    output reg          MemWrite, 
    output reg          MemRead, 
    output reg [1:0]    Branch, 
    output reg [3:0]    ALUControl, 
    output reg          ALUSrc, 
    output reg          RegDst, 
    output reg          Jump, 
    output reg          Jal, 
    output reg          Jr, 
    output reg          ShiftSrc // 1 -> shamt, 0 -> rs
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

    wire [31:0]         instruction;
    // wire                stall;

    always @(*) begin
        /* defaults */
        MemtoReg <= 1'b0;
        RegWrite <= 1'b1;
        MemWrite <= 1'b0;
        MemRead <= 0;
        Branch <= 2'b00;
        ALUControl <= 4'b1111; /* no such control */
        ALUSrc <= 1'b0;
        RegDst <= 1'b0;
        Jump <= 1'b0;
        Jal <= 0;
        Jr <= 0;
        ShiftSrc <= 0;

        /* FROM OLD, WITH BUG
        if (stall) begin 
            MemtoReg <= 0;
            RegWrite <= 0;
            MemWrite <= 0;
            MemRead <= 0;
            Branch <= 2'b00;
            ALUControl <= 4'b1111; 
            ALUSrc <= 0;
            RegDst <= 0;
            Jump <= 1'b0;
        end
        */
        
        case (instruction[31:26])
            6'b000000: begin
                case (instruction[5:0]) 
                    /* add */
                    6'h20: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0010; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                    end

                    /* addu */
                    6'h21: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0010; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                        
                    end

                    /* and */
                    6'h24: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0000; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                    end

                    /* or */
                    6'h25: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0001; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                        
                    end

                    /* sub */
                    6'h22: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0110; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                        
                    end

                    /* subu */
                    6'h23: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0110; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                        
                    end

                    /* nor */
                    6'h27: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b1100; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                        
                    end

                    /* xor */
                    6'h26: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b1101; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                        
                    end

                    /* slt */
                    6'h2a: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0111; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                        
                    end

                    /* sll */
                    6'h0: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0100; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 1;
                    end

                    /* sllv */
                    6'h4: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0100; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                    end

                    /* srl */
                    6'h2: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0101; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 1;
                    end

                    /* srlv */
                    6'h6: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0101; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                    end

                    /* sra */
                    6'h3: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0011; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 1;
                    end

                    /* srav */
                    6'h7: begin
                        MemtoReg <= 0;
                        RegWrite <= 1;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b00;
                        ALUControl <= 4'b0011; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        ShiftSrc <= 0;
                    end

                    /* jr */
                    6'h8: begin
                        MemtoReg <= 0;
                        RegWrite <= 0;
                        MemWrite <= 0;
                        MemRead <= 0;
                        Branch <= 2'b11;
                        ALUControl <= 4'b1111; 
                        ALUSrc <= 0;
                        RegDst <= 0;
                        Jump <= 0;
                        Jal <= 0;
                        Jr <= 1;
                        ShiftSrc <= 0;
                    end
                endcase
            end

            /* beq */
            6'h4: begin
                MemtoReg <= 0;
                RegWrite <= 0;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b01;
                ALUControl <= 4'b0110; 
                ALUSrc <= 0;
                RegDst <= 0;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end

            /* bne */
            6'h5: begin
                MemtoReg <= 0;
                RegWrite <= 0;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b10;
                ALUControl <= 4'b0110; 
                ALUSrc <= 0;
                RegDst <= 0;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end
            /* lw */
            6'h23: begin
                MemtoReg <= 1;
                RegWrite <= 1;
                MemWrite <= 0;
                MemRead <= 1;
                Branch <= 2'b00;
                ALUControl <= 4'b0010; 
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end

            /* sw */
            6'h2b: begin
                MemtoReg <= 0;
                RegWrite <= 0;
                MemWrite <= 1;
                MemRead <= 1;
                Branch <= 2'b00;
                ALUControl <= 4'b0010;
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end

            /* addi */
            6'h8: begin
                MemtoReg <= 0;
                RegWrite <= 1;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b00;
                ALUControl <= 4'b0010;
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end

            /* addiu */
            6'h9: begin
                MemtoReg <= 0;
                RegWrite <= 1;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b00;
                ALUControl <= 4'b0010;
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end

            /* andi */
            6'hc: begin
                MemtoReg <= 0;
                RegWrite <= 1;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b00;
                ALUControl <= 4'b0000;
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end


            /* ori */
            6'hd: begin
                MemtoReg <= 0;
                RegWrite <= 1;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b00;
                ALUControl <= 4'b0001;
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end

            /* xori */
            6'he: begin
                MemtoReg <= 0;
                RegWrite <= 1;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b00;
                ALUControl <= 4'b1101;
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 0;
                Jal <= 0;
                ShiftSrc <= 0;
                
            end

            /* j */
            6'h2: begin
                MemtoReg <= 0;
                RegWrite <= 0;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b00;
                ALUControl <= 4'b1111;
                ALUSrc <= 1; 
                RegDst <= 1;
                Jump <= 1;
                Jal <= 0;
                ShiftSrc <= 0;
            end
                
            /* jal */
            6'h3: begin
                MemtoReg <= 0;
                RegWrite <= 1;
                MemWrite <= 0;
                MemRead <= 0;
                Branch <= 2'b00;
                ALUControl <= 4'b0010;
                ALUSrc <= 0; 
                RegDst <= 0;
                Jump <= 1;
                Jal <= 1;
                ShiftSrc <= 0;
            end

        endcase
    end

endmodule

`endif