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

`ifndef _CPU
`define _CPU

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
    input               clk
);

    wire                clk;
    initial begin
        _pc_in <= 32'h0000_0000;
    end


    /* PC instantiation */
    reg [31:0]          _pc_data;
    /* TODO */
    always @(*) begin
        _pc_data <= _pc_in;
        // $display("From CPU-PC. PC: %32b", _pc_data);
    end
    wire                _pc_write;
    reg [31:0]          _pc_in; /* ready for mux */
    wire [31:0]         _pc_out;
    PC _pc (
        clk, 
        _pc_write, /* _pc_write */
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
    wire                _if_id_write; /* ready for control */
    wire [31:0]         _if_id_pc_out;
    wire [31:0]         _if_id_ins_out;
    IF_ID _if_id (
        clk, 
        _if_id_write, 
        _pc4, 
        instruction, 
        _if_id_pc_out, 
        _if_id_ins_out 
    );

    /* RegisterFile */
    wire                _reg_write;
    wire [4:0]          _write_reg;
    wire [31:0]         _write_data;
    wire [31:0]         _read_data1;
    wire [31:0]         _read_data2;
    RegisterFile _reg_file (
        clk, 
        _mem_wb_reg_write, 
        _if_id_ins_out[25:21], 
        _if_id_ins_out[20:16],
        _write_reg, 
        _write_data, 
        _read_data1, 
        _read_data2
    );

    /* Sign-Extend */
    wire [31:0]         _signed_data;
    SignExtend _sign_extend (
        _if_id_ins_out[15:0], 
        _signed_data
    );

    /* Adder_PC_Branch */
    wire [31:0]         _pcBranch;
    Adder _pc_branch (
        _signed_data << 2, 
        _if_id_pc_out, 
        _pcBranch
    ); 

    /* Control Unit */
    wire                _stall;
    wire                _mem_to_reg;
    /* wire _reg_write */
    wire                _mem_write;
    wire                _mem_read;
    wire [1:0]          _branch;
    /* TODO: put alu control unit in the main
            control unit? */
    wire [3:0]          _alu_control;
    wire                _alu_src;
    wire                _reg_dst;
    wire                _jump;
    wire                _jal;
    ControlUnit _control_unit (
        _if_id_ins_out, 
        _mem_to_reg, 
        _reg_write, 
        _mem_write, 
        _mem_read, 
        _branch, 
        _alu_control, 
        _alu_src, 
        _reg_dst,
        _jump, 
        _jal, 
        _jr, 
        _shift_src
    );

    /* Hazard Detection Unit */
    wire                _id_ex_mem_read;
    /* wire [1:0] _branch; */
    wire [4:0]          _id_ex_register_rd;
    wire [4:0]          _id_ex_register_rt;
    wire [4:0]          _ex_mem_register_rd;
    wire [4:0]          _if_id_register_rs;
    wire [4:0]          _if_id_register_rt;
    /* wire _pc_write; */
    /* wire _stall */
    HazardUnit _hazard_unit (
        _id_ex_mem_read, 
        _ex_mem_mem_read, 
        _branch, 
        _delay, 
        ex_mem_register_rd_in,  
        _ex_mem_register_rd, 
        _if_id_register_rs, 
        _if_id_register_rt, 
        _pc_write, 
        _if_id_write, 
        _stall
    );

    /* Suber */
    reg [31:0]          _src_a;
    reg [31:0]          _src_b;
    wire [31:0]         _suber_data1;
    wire [31:0]         _suber_data2;
    assign _suber_data1 = _src_a;
    assign _suber_data2 = _src_b;
    wire [31:0]         _result;
    wire                _zero;
    wire                _neg;
    Suber _suber (
        _suber_data1, 
        _suber_data2, 
        _result, 
        _zero, 
        _neg
    );

    /* Branch Forward */
    /* wire [1:0] _branch; */
    /* wire [4:0] _ex_mem_register_rd; */
    wire [4:0]          _mem_wb_register_rd;
    /* wire [4:0] _if_id_register_rs; */
    /* wire [4:0] _if_id_register_rt; */
    wire [1:0]          _branch_forward_a;
    wire [1:0]          _branch_forward_b;
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
    wire [31:0]         _ex_mem_alu_result;
    wire [31:0]         _mem_wb_read_data;
    always @(*) begin
        case (_branch_forward_a)
            2'b00:
                _src_a = _read_data1;
            2'b10:
                _src_a = _ex_mem_alu_result;
            2'b01:
                _src_a = _wb_data;
        endcase
        case (_branch_forward_b)
            2'b00:
                _src_b = _read_data2;
            2'b10:
                _src_b = _ex_mem_alu_result;
            2'b01:
                _src_b = _wb_data;
        endcase
    end
    /*
    assign _src_a = (_branch_forward_a == 2'b00) ? _read_data1 : 
                    ((_branch_forward_a == 2'b10) ? _ex_mem_alu_result : _mem_wb_read_data); 
    assign _src_b = (_branch_forward_b == 2'b00) ? _read_data2 : 
                    ((_branch_forward_b == 2'b10) ? _ex_mem_alu_result : _mem_wb_read_data); 
    */ 

    /* Branch Unit */
    wire                _pc_src;
    BranchUnit _branch_unit (
        _branch, 
        _zero, 
        _pc_src
    );

    /* mux before PC */
    /* TODO: jump */
    reg [31:0]         _jump_addr;
    always @(*) begin
        _jump_addr = {_if_id_pc_out[31:28], _if_id_ins_out[25:0], 2'b00};
        _pc_in = _pc4;
        case (_pc_src)
            1'b1:
                case (_jr)
                    1'b0:
                        _pc_in = _pcBranch;
                    1'b1:
                        _pc_in = _src_a; // from branch forward

                endcase
            1'b0: begin
                case (_jump) 
                    1'b0:
                        _pc_in = _pc4;
                    1'b1:
                        _pc_in = _jump_addr;
                endcase
            end
        endcase
    end

    /* ID_EX */
    assign _if_id_register_rs = _if_id_ins_out[25:21];
    assign _if_id_register_rt = _if_id_ins_out[20:16];
    wire [4:0]          _if_id_register_rd;
    assign _if_id_register_rd = _if_id_ins_out[15:11];
    wire [4:0]          _shamt;
    wire                _shift_src;
    assign _shamt = _if_id_ins_out[10:6];
    wire                _id_ex_mem_to_reg;
    wire                _id_ex_reg_write;
    wire                _id_ex_mem_write;
    /* wire _id_ex_mem_read; */
    wire [1:0]          _id_ex_branch;
    wire [3:0]          _id_ex_alu_control;
    wire                _id_ex_alu_src;
    wire                _id_ex_reg_dst;
    wire [31:0]         _id_ex_read_data1;
    wire [31:0]         _id_ex_read_data2;
    wire [31:0]         _id_ex_extended_data;
    wire [4:0]          _id_ex_register_rs;
    /* wire [4:0] _id_ex_register_rt; */
    /* wire [4:0] _id_ex_register_rd; */
    wire                _id_ex_pc_src;
    wire [4:0]          _id_ex_shamt;
    wire                _id_ex_shift_src;
    wire [31:0]         _new_read_data1;
    wire [31:0]         _new_read_data2;
    wire [4:0]          _new_if_id_register_rd;
    assign _new_read_data1 = (_jal) ? 32'd0 : _read_data1;
    assign _new_read_data2 = (_jal) ? _if_id_pc_out : _read_data2;
    assign _new_if_id_register_rd = (_jal) ? 5'd31 : _if_id_register_rd;

    ID_EX _id_ex (
        clk, 
        _stall, 
        _mem_to_reg, 
        _reg_write, 
        _mem_write, 
        _mem_read, 
        _branch, 
        _jump, 
        _pc_src, 
        _alu_control, 
        _alu_src, 
        _reg_dst, 
        _new_read_data1, 
        _new_read_data2, 
        _signed_data, 
        _if_id_register_rs, 
        _if_id_register_rt, 
        _new_if_id_register_rd, 
        _shamt, 
        _shift_src, 
        _id_ex_mem_to_reg, 
        _id_ex_reg_write, 
        _id_ex_mem_write, 
        _id_ex_mem_read, 
        _id_ex_branch, 
        _id_ex_jump, 
        _id_ex_pc_src, 
        _id_ex_alu_control, 
        _id_ex_alu_src, 
        _id_ex_reg_dst, 
        _id_ex_read_data1, 
        _id_ex_read_data2, 
        _id_ex_extended_data, 
        _id_ex_register_rs, 
        _id_ex_register_rt, 
        _id_ex_register_rd, 
        _id_ex_shamt, 
        _id_ex_shift_src
    );

    wire                _delay;
    wire                _id_ex_jump;
    BranchDelay _branch_delay (
        _id_ex_branch, 
        _id_ex_pc_src, 
        _id_ex_jump, 
        _delay
    );

    /* ALU */ 
    reg [31:0]          _alu_src_a;
    reg [31:0]          _alu_src_b;
    wire                _alu_zero;
    wire [31:0]         _alu_result;

    ALU _alu (
        _alu_src_a, 
        _alu_src_b, 
        _id_ex_alu_control, 
        _alu_zero, 
        _alu_result
    );

    /* Forwarding Unit */ 
    
    wire [1:0]          _forward_a;
    wire [1:0]          _forward_b;
    wire                _sw_forwarding;

    ForwardingUnit _forwarding_unit (
        _id_ex_mem_write, 
        _ex_mem_reg_write, 
        _mem_wb_reg_write, /* TODO */
        _ex_mem_register_rd, 
        _mem_wb_register_rd, 
        _id_ex_register_rs, 
        _id_ex_register_rt, 
        _forward_a, 
        _forward_b, 
        _sw_forwarding
    );

    /* mux around ALU */
    reg [31:0]          ex_mem_write_data_in;
    reg [4:0]           ex_mem_register_rd_in;
    reg [31:0]          _sw_forwarding_result;
    always @(*) begin
        case (_forward_a)
            2'b00:
                _alu_src_a = (_id_ex_shift_src) ? {27'd0, _id_ex_shamt} : _id_ex_read_data1;
            2'b10:
                _alu_src_a = _ex_mem_alu_result;
            2'b01:
                _alu_src_a = _wb_data; /* TODO */
        endcase

        case (_forward_b)
            2'b00: begin
                _sw_forwarding_result = (_sw_forwarding) ? _ex_mem_alu_result : _id_ex_read_data2;

                _alu_src_b = (_id_ex_alu_src) ? _id_ex_extended_data : _sw_forwarding_result;
            end
            2'b10:
                _alu_src_b = _ex_mem_alu_result;
            2'b01:
                _alu_src_b = _wb_data;
        endcase

        
        ex_mem_write_data_in = _sw_forwarding_result;

        ex_mem_register_rd_in = (_id_ex_reg_dst) ? _id_ex_register_rt : _id_ex_register_rd;
    end

    /* EX_MEM */
    wire                _ex_mem_mem_to_reg;
    wire                _ex_mem_reg_write;
    wire                _ex_mem_mem_write;
    wire                _ex_mem_mem_read;
    /* wire [31:0] _ex_mem_alu_result; */
    wire                _ex_mem_zero;
    wire [31:0]         _ex_mem_write_data;
    /* wire [4:0] _ex_mem_register_rd; */
    EX_MEM _ex_mem (
        clk, 
        _id_ex_mem_to_reg, 
        _id_ex_reg_write, 
        _id_ex_mem_write, 
        _id_ex_mem_read, 
        _alu_result, 
        _alu_zero, 
        ex_mem_write_data_in, 
        ex_mem_register_rd_in, 
        _ex_mem_mem_to_reg, 
        _ex_mem_reg_write, 
        _ex_mem_mem_write, 
        _ex_mem_mem_read, 
        _ex_mem_alu_result, 
        _ex_mem_zero, 
        _ex_mem_write_data, 
        _ex_mem_register_rd
    );

    /* Main Memory */
    wire [31:0]         _mem_data;
    MainMemory _mem (
        clk, 
        1'b0, 
        1'b1, 
        _ex_mem_alu_result >> 2, 
        {_ex_mem_mem_write, _ex_mem_alu_result >> 2, _ex_mem_write_data}, 
        _mem_data
    );

    /* MEM_WB */ 
    wire                _mem_wb_mem_to_reg;
    wire                _mem_wb_reg_write;
    /* wire [31:0] _mem_wb_read_data; */
    wire [31:0]         _mem_wb_alu_result;
    /* wire [4:0] _mem_wb_register_rd; */ 
    MEM_WB _mem_wb (
        clk, 
        _ex_mem_mem_to_reg, 
        _ex_mem_reg_write, 
        _mem_data, 
        _ex_mem_alu_result, 
        _ex_mem_register_rd, 
        _mem_wb_mem_to_reg, 
        _mem_wb_reg_write, 
        _mem_wb_read_data, 
        _mem_wb_alu_result, 
        _mem_wb_register_rd
    ); 

    /* WB */
    wire [31:0] _wb_data;
    assign _wb_data = (_mem_wb_mem_to_reg) ? _mem_wb_read_data : _mem_wb_alu_result;
    assign _write_data = _wb_data;
    assign _write_reg = _mem_wb_register_rd;
endmodule

`endif