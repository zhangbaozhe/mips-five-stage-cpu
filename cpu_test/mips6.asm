.text
# To test the instructions j, jr, jal

addi $s0, $zero, 1
addi $s1, $zero, 1
addi $s2, $zero, 1
addi $s3, $zero, 1
addi $s4, $zero, 1
addi $s5, $zero, 1
addi $v0, $zero, 96
addi $a0, $zero, 2
addi $a1, $zero, 4
addi $a2, $zero, 8
addi $t0, $zero, 16
addi $t1, $zero, 32
addi $t2, $zero, 64
j _17
addi $s0, $zero, 200 # if j succeeds, this should be skipped
addi $s1, $zero, 400 # if j succeeds, this should be skipped
addi $s2, $zero, 800 # if j succeeds, this should be skipped
_17:                    # j makes pc moves to here
addi $a0, $zero, -2 # $a0 shoule be -2
addi $a1, $zero, -4 # $a1 should be -4
addi $a2, $zero, -8 # $a2 should be -8
jr $v0
addi $s3, $zero, 160 # if jr succeeds, this should be skipped
addi $s4, $zero, 320 # if jr succeeds, this should be skipped
addi $s5, $zero, 640 # if jr succeeds, this should be skipped
                    # jr makes pc moves to here
addi $t0, $zero, -16 # $t0 shoule be -16
addi $t1, $zero, -32 # $t1 should be -32
addi $t2, $zero, -64 # $t2 should be -64
jal _32
                      #jr jumps back to here
addi $t3, $zero, 128  # $t3 shoule be 128
addi $t4, $zero, 256  # $t3 shoule be 256
addi $t5, $zero, 512  # $t3 shoule be 512
j _36
_32:
addi $k0, $zero, 1 # meaningless instruction, just to avoid other hazards
addi $k0, $zero, 1 # meaningless instruction, just to avoid other hazards
addi $k0, $zero, 1 # meaningless instruction, just to avoid other hazards
jr $ra  # jal jumps to here
_36:                  # j jumps to here
addi $fp, $zero, 8192
sw $a0, 0($fp)  # -2 in DATA_MEM[0]
sw $a1, 4($fp)  # -4 in DATA_MEM[1]
sw $a2, 8($fp)  # -8 in DATA_MEM[2]
sw $t0, 12($fp) # -16 in DATA_MEM[3]
sw $t1, 16($fp) # -32 in DATA_MEM[4]
sw $t2, 20($fp) # -64 in DATA_MEM[5]
sw $t3, 24($fp) # 128 in DATA_MEM[6]
sw $t4, 28($fp) # 256 in DATA_MEM[7]
sw $t5, 32($fp) # 512 in DATA_MEM[8]
sw $s0, 36($fp) # 1 in DATA_MEM[9]
sw $s1, 40($fp) # 1 in DATA_MEM[10]
sw $s2, 44($fp) # 1 in DATA_MEM[11]
sw $s3, 48($fp) # 1 in DATA_MEM[12]
sw $s4, 52($fp) # 1 in DATA_MEM[13]
sw $s5, 56($fp) # 1 in DATA_MEM[14]
