/* 
 * File Name: CPU.v
 * Author:    ZHANG Baozhe
 * Date:      May , 2021
 * ----------------------------
 * This file is the core part of this project in which it connects
 * all other parts. In this file, a clock is constructed, the modules
 * are connected, and some I/O about files may be concerned.
 *  
 */

`include "Adder.v"
`include "ALU.v"
`include "BranchForward.v"
`include "BranchUnit.v"
`include "ControlUnit.v"
`include "ForwardingUnit.v"
`include "HazardUnit.v"
`include "InstructionRAM.v"
`include "MainMemory.v"
`include "RegisterFile.v"
`include "SignExtend.v"
`include "StageRegs.v"
`include "Suber.v"

module CPU (
    input clk
);

reg clk;

/* PC instantiation */
wire _pc_write;
wire [31:0] _pc_in; /* ready for mux */
wire [31:0] _pc_out;
PC _pc (
    clk, 
    _pc_write, 
    _pc_in, 
    _pc_out
);

/* InstructionRAM */ 
wire [31:0] instruction;
InstructionRAM _ins_ram (
    clk, 
    1'b0, 
    1'b1, 
    _pc_out >> 2, 
    instruction
);

/* Adder_PC_4 */
wire [31:0] _pc4; /* ready for mux */
Adder _adder (
    _pc_out, 
    32'd4, 
    _pc4
);

/* IF_ID */
wire _if_id_write; /* ready for control */
wire [31:0] _if_id_pc_out;
wire [31:0] _if_id_ins_out;
IF_ID _if_id (
    clk, 
    _if_id_write, 
    _pc4, 
    instruction, 
    _if_id_pc_out, 
    _if_id_ins_out 
);

/* RegisterFile */
wire _reg_write;
wire [4:0] _write_reg;
wire [31:0] _write_data;
wire [31:0] _read_data1;
wire [31:0] _read_data2;
RegisterFile _reg_file (
    clk, 
    _reg_write, 
    instruction[25:21], 
    instruction[20:16],
    _write_reg, 
    _write_data, 
    _read_data1, 
    _read_data2
);

/* Sign-Extend */
wire [31:0] _signed_data;
SignExtend _sign_extend (
    instruction[15:0], 
    _signed_data
);

/* Adder_PC_Branch */
wire [31:0] _pcBranch;
Adder _pc_branch (
    _signed_data << 2, 
    _if_id_pc_out, 
    _pcBranch
); 

/* Control Unit */
wire _stall;
wire _mem_to_reg;
/* wire _reg_write */
wire _mem_write;
wire _mem_read;
wire [1:0] _branch;
/* TODO: put alu control unit in the main
         control unit? */
wire [3:0] _alu_control;
wire _alu_src;
wire _reg_dst;
ControlUnit _control_unit (
    instruction, 
    _stall, 
    _mem_to_reg, 
    _reg_write, 
    _mem_write, 
    _mem_read, 
    _branch, 
    _alu_control, 
    _alu_src, 
    _reg_dst
);

/* Hazard Detection Unit */
wire _id_ex_mem_read;
/* wire [1:0] _branch; */
wire [4:0] _id_ex_register_rd;
wire [4:0] _id_ex_register_rt;
wire [4:0] _ex_mem_register_rd;
wire [4:0] _if_id_register_rs;
wire [4:0] _if_id_register_rt;
/* wire _pc_write; */
/* wire _stall */
HazardUnit _hazard_unit (
    _id_ex_mem_read, 
    _branch, 
    _id_ex_register_rd, 
    _id_ex_register_rt, 
    _ex_mem_register_rd, 
    _if_id_register_rs, 
    _if_id_register_rt, 
    _pc_write, 
    _if_id_write, 
    _stall
);

/* Suber */
wire [31:0] _src_a;
wire [31:0] _src_b;
wire [31:0] _result;
wire _zero;
wire _neg;
Suber _suber (
    _src_a, 
    _src_b, 
    _result, 
    _zero, 
    _neg
);

/* Branch Forward */
/* wire [1:0] _branch; */
/* wire [4:0] _ex_mem_register_rd; */
wire [4:0] _mem_wb_register_rd;
/* wire [4:0] _if_id_register_rs; */
/* wire [4:0] _if_id_register_rt; */
wire [1:0] _branch_forward_a;
wire [1:0] _branch_forward_b;
BranchForward _branch_forward (
    _branch, 
    _ex_mem_register_rd, 
    _mem_wb_register_rd, 
    _if_id_register_rs, 
    _if_id_register_rt, 
    _branch_forward_a, 
    _branch_forward_b
);

/* mux before suber */
wire [31:0] _ex_mem_alu_result;
wire [31:0] _mem_wb_read_data;
assign _src_a = (_branch_forward_a == 2'b00) ? _read_data1 : 
                (_branch_forward_a == 2'b10) ? _ex_mem_alu_result : _mem_wb_read_data; 
assign _src_b = (_branch_forward_b == 2'b00) ? _read_data2 : 
                (_branch_forward_b == 2'b10) ? _ex_mem_alu_result : _mem_wb_read_data; 

/* Branch Unit */
wire _pc_src;
BranchUnit _branch_unit (
    _branch, 
    _zero, 
    _pc_src
);

/* mux before PC */
assign _pc_in = (_pc_src) ? _pcBranch : _pc4;

/* ID_EX */
ID_EX _id_ex (
    clk, 
    _mem_to_reg, 
    _reg_write
)

endmodule