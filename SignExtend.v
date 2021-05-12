/* 
 * File Name: SignExtend.v
 * Author:    ZHANG Baozhe
 * Date:      April , 2021
 * ----------------------------
 * This file implements the sign-extension
 * part in the CPU
 * 
 */

module SignExtend (
    input [15:0] data, 
    output reg [31:0] result
);

/* Inputs declaration */
wire signed [15:0] data;

/* Main function */
always @(*) begin
    if (data[15] == 1)
        result = {16'b1111_1111_1111_1111, data};
    else
        result = {16'b0000_0000_0000_0000, data};
end

endmodule