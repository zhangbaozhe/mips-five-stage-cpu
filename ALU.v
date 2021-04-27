/* 
 * File Name: ALU.v
 * Author:    ZHANG Baozhe
 * Date:      April , 2021
 * ----------------------------
 * This file implements the ALU 
 * in the CPU
 * 
 */

module ALU (
    input [31:0] data1, 
    input [31:0] data2, 
    input [3:0]  ALUControl, 
    output reg ZERO, 
    output reg [31:0] result
);
/* 
 * Implementation Notes:
 * ---------------------------------------------------------
 * INPUTS:
 * data1 -> the first input data
 * data2 -> the second input data
 * ALUControl -> the 4-bit ALU control signal
 * OUTPUTS:
 * ZERO -> zero flag
 * result -> the computed result
 */

/* Inputs declaration */
wire signed [31:0] data1;
wire signed [31:0] data2;
wire [3:0]         ALUControl;

always @(*) begin
    case (ALUControl) 
        /* AND */
        4'b0000: begin
            result = data1 & data2;
        end

        /* OR */
        4'b0001: begin
            result = data1 | data2;
        end

        /* add */
        4'b0010: begin
            result = data1 + data2;
        end

        /* subtract */
        4'b0110: begin
            result = data1 - data2;
        end

        /* set on less than */
        4'b0111: begin
            result = (data1 < data2);
        end

        /* NOR */
        4'b1100: begin
            result = ~(data1 | data2);
        end
    endcase

    ZERO = (result == 32'b0);
end


endmodule