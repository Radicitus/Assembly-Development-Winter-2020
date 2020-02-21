# Cameron Sherry
# crsherry

.text
F:
    # PROLOGUE START #
    addi $sp, $sp, -8 #Move stack pointer down by 8
    sw $s0, 0($sp) #Store n for function call
    sw $ra, 4($sp) #Store return register for function call
    # PROLOGUE END #
    move $s0, $a0 #Store arg n in s0
    
	move $s0, $a0   # Save argument, n

	li $v0, 4       # Print F label
	la $a0, F_label
	syscall

	li $v0, 1       # Print n value
	move $a0, $s0
	syscall

	li $v0, 11      # Print newline
	li $a0 '\n'
	syscall

	bnez $s0, F_recurse # Check n for recursion
	li $v0, 1           # N == 0, it's base case!
	
F_done: #Leaf-Like
    # EPLILOGUE START #
    lw $s0, 0($sp) #Load previous function's n value
    lw $ra, 4($sp) #Load return register for previous function call
    addi $sp, $sp, 8 #Move stack up by 8
    # EPILOGUE END #
	jr $ra

F_recurse:
    ####################
    # Calculate & Load F arguments here
    ####################
    addi $a0, $s0, -1
	jal F				# F(n-1)
    
    ####################
    # Load M arguments here
    ####################
    move $a0, $v0
	jal M               # M(F(n-1))
    ####################
    # Caluculate return value here 
    # n - M(F(n-1))
    ####################
    sub $v0, $s0, $v0 
	j F_done



M:
    # PROLOGUE START #
    addi $sp, $sp, -8 #Move stack pointer down by 8
    sw $s0, 0($sp) #Store n for function call
    sw $ra, 4($sp) #Store return register for function call
    # PROLOGUE END #
    move $s0, $a0 #Store arg n in t0

	move $s0, $a0       # Save argument, n

	li $v0, 4           # Print F label
	la $a0, M_label
	syscall

	li $v0, 1           # Print n value
	move $a0, $s0
	syscall

	li $v0, 11          # Print newline
	li $a0 '\n'
	syscall

	bnez $s0, M_recurse # Check n for recursion
	li $v0, 0           # N == 0, it's base case!
M_done:
    # EPLILOGUE START #
    lw $s0, 0($sp) #Load previous function's n value
    lw $ra, 4($sp) #Load return register for previous function call
    addi $sp, $sp, 8 #Move stack up by 8
    # EPILOGUE END #
	jr $ra

M_recurse:
    ####################
    # Calculate & Load M arguments here
    ####################
    addi $a0, $s0, -1
	jal M				# M(n-1)
    ####################
    # Load F arguments here
    ####################
    move $a0, $v0
	jal F               # F(M(n-1))
    ####################
    # Caluculate return value here 
    # n - F(M(n-1))
    ####################
    sub $v0, $s0, $v0 
	j M_done


.data
F_label: .asciiz "F: "
M_label: .asciiz "M: "

