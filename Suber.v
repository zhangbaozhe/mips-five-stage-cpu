/* 
 * File Name: Suber.v
 * Author:    ZHANG Baozhe
 * Date:      April , 2021
 * ----------------------------
 * This file implements the subtractor 
 * in the CPU
 * 
 */

module Suber (
    input [31:0] data1, 
    input [31:0] data2, 
    output reg [31:0] result,
    output reg zero, 
    output reg neg
);

/* Inputs declaration */
wire signed [31:0] data1;
wire signed [31:0] data2;

/* Main function */
always @(*) begin
    result = data1 - data2;
    zero = (result == 32'b0);
    neg  = (result < 0);
end

endmodule