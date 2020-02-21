# Cameron Sherry
# crsherry

.text
processStrings:
	
	#PROLOGUE
	
	addi $sp, $sp, -36
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	sw $ra, 32($sp)
	
	#
	
	move $s0, $a0 #Move strArray to $s0
	move $s1, $a1 #Move numStr to $s1
	
	li $t0, 0 #Counter for zeroing out total_histarray
	la $t1, total_histarray #Load address of total_histArray
	li $t2, 0 #Zeroing var
	zeroArray:
	     beq $t0, 25, zeroArrayDone
	     sw $t2, ($t1) #Zero out the index
	     addi $t0, $t0, 1 #Increment counter
	     addi $t1, $t1, 4 #Increment array address
	     j zeroArray
	zeroArrayDone: 
	     li $s2, 0 #Init total symbols variable
	     li $s3, 0 #Init total spaces variable
	
	
	la $s4, cur_histarray #Init cur_histArray
	li $s5, 0 #Counter for string loop
	move $s6, $s0 #Load address of strArray
	stringLoop:
	     beq $s5, $s1, stringLoopDone
	    
	     lw $t0, ($s6)
	     move $a0, $s4 #Set arg1 to cur_histarray
	     move $a1, $t0 #Set arg2 to the address of the loaded string
	     jal countAllChars
	     
	     add $s2, $s2, $v0 #Add symbols for string to total symbols
	     add $s3, $s3, $v1 #Add spaces for string to total spaces
	     
	     move $a0, $s4 #Set arg1 to cur_histarray
	     la $a1, total_histarray #Set arg2 to total_histarray
	     li $a2, 26 #Set arg3 to 26
	     jal addArray
	     
	     move $a0, $s3 #Set arg1 to total_spaces var
	     move $a1, $s2 #Set arg2 to total_sym var
	     la $a2, total_histarray #Set arg3 to total_histarray
	     jal printStats
	     
	     addi $s5, $s5, 1 #Increment counter
	     addi $s6, $s6, 4 #Increment array address
	     
	     j stringLoop
	    
	stringLoopDone:
	#EPILOGUE
	
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $s5, 20($sp)
	lw $s6, 24($sp)
	lw $s7, 28($sp)
	lw $ra, 32($sp)
	addi $sp, $sp, 36
	
	#
	
	
    li $v0, -222

	jr $ra


.data
total_histarray: .word ,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-18,-19,-20,-21,-22,-23,-24,-25
cur_histarray: .word ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
