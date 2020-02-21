# Cameron Sherry
# crsherry

.text
countAllChars:

    addi $sp, $sp, -24
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $s4, 16($sp)
    sw $ra, 20($sp)
    
    move $s0, $a0
    move $s1, $a1

    li $s2, 0
    li $s3, 33
    countSLoop:
         beq $s3, 65, countSLoopDone
         move $a0, $s1
         move $a1, $s3
         jal countC
         add $s2, $s2, $v0
         addi $s3, $s3, 1
         j countSLoop
    countSLoopDone:
    
    li $s4, 0
    move $a0, $s1
    li $a1, 32
    jal countC
    add $s4, $s4, $v0
    
    li $s3, 65
    countALoop:
         beq $s3, 91, countALoopDone
         move $a0, $s1
         move $a1, $s3
         jal countC
         
         addi $t0, $s3, -65
         li $t1, 4
         mul $t0, $t0, $t1
         add $t0, $s0, $t0
         sw $v0, ($t0) 
         
         addi $s3, $s3, 1
         j countALoop
    countALoopDone:
    
    move $v0, $s2
    move $v1, $s4
    move $ra, $s7

    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $s4, 16($sp)
    lw $ra, 20($sp)
    addi $sp, $sp, 24
	jr $ra

