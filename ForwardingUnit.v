/* 
 * File Name: ForwardingUnit.v
 * Author:    ZHANG Baozhe
 * Date:      April , 2021
 * ----------------------------
 * This file implements the forwarding unit of 
 * the five-stage MIPS CPU.
 * 
 * This unit solves two kinds of hazard: 
 *      1a. EX/MEM.RegisterRd = ID/EX.RegisterRs
 *      1b. EX/MEM.RegisterRd = ID/EX.RegisterRt
 *      2a. MEM/WB.RegisterRd = ID/EX.RegisterRs
 *      2b. MEM/WB.RegisterRd = ID/EX.RegisterRt 
 * 
 * For example:
 *      sub $2,     $1, $3
 *      and $12,    $2, $5 # 1a
 *      or  $13,    $6, $2 # 2b
 * 
 */

module ForwardingUnit (
    input EX_MEM_RegWrite, 
    input MEM_WB_RegWirte, 
    input [4:0] EX_MEM_RegisterRd, 
    input [4:0] MEM_WB_RegisterRd, 
    input [4:0] ID_EX_RegisterRs, 
    input [4:0] ID_EX_RegisterRt, 
    output reg [1:0] ForwardA, 
    output reg [1:0] ForwardB
    output reg IsForwarding
);

/* input declaration */
wire EX_MEM_RegWrite;
wire MEM_WB_RegWirte;
wire [4:0] EX_MEM_RegisterRd;
wire [4:0] MEM_WB_RegisterRd;
wire [4:0] ID_EX_RegisterRs;
wire [4:0] ID_EX_RegisterRt;

always @(*) begin
    
    /* EX hazard */ 
    if (EX_MEM_RegWrite 
        && (EX_MEM_RegisterRd != 5'b00000) 
        && (EX_MEM_RegisterRd == ID_EX_RegisterRs))
        begin
            ForwardA = 2'b10;
            ForwardB = 2'b00;
            IsForwarding = 1'b1;
        end

    
    else if (EX_MEM_RegWrite 
        && (EX_MEM_RegisterRd != 5'b00000) 
        && (EX_MEM_RegisterRd == ID_EX_RegisterRt))
        begin
            ForwardA = 2'b00;
            ForwardB = 2'b10;
            IsForwarding = 1'b1;
        end

    /* MEM hazard */
    else if (MEM_WB_RegWirte
        && (MEM_WB_RegisterRd != 5'b00000)
        && ! (EX_MEM_RegWrite 
              && (EX_MEM_RegisterRd != 5'b00000)
              && (EX_MEM_RegisterRd == ID_EX_RegisterRs))
        && (MEM_WB_RegisterRd == ID_EX_RegisterRs))
        begin
            ForwardA = 2'b01;
            ForwardB = 2'b00;
            IsForwarding = 1'b1;
        end

    else if (MEM_WB_RegWirte
        && (MEM_WB_RegisterRd != 5'b00000)
        && ! (EX_MEM_RegWrite 
              && (EX_MEM_RegisterRd != 5'b00000)
              && (EX_MEM_RegisterRd == ID_EX_RegisterRt))
        && (MEM_WB_RegisterRd == ID_EX_RegisterRt))
        begin
            ForwardA = 2'b00;
            ForwardB = 2'b01;
            IsForwarding = 1'b1;
        end
    
    else begin
        ForwardA = 2'b00;
        ForwardB = 2'b00;
        IsForwarding = 1'b0;
    end

end

endmodule