# Cameron Sherry
# crsherry

.text
F:
    ####################
    # Add prologue here
    ####################
    
    
    
    ####################
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
F_done:
    ####################
    # Add epilogue here
    ####################
	jr $ra

F_recurse:
    ####################
    # Calculate & Load F arguments here
    ####################
     
	jal F				# F(n-1)
    ####################
    # Load M arguments here
    ####################
	jal M               # M(F(n-1))
    ####################
    # Caluculate return value here 
    # n - M(F(n-1))
    ####################
	j F_done



M:
    ####################
    # Add prologue here
    ####################

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
    ####################
    # Add epilogue here
    ####################
	jr $ra

M_recurse:
    ####################
    # Calculate & Load M arguments here
    ####################
	jal M				# M(n-1)
    ####################
    # Load F arguments here
    ####################
	jal F               # F(M(n-1))
    ####################
    # Caluculate return value here 
    # n - F(M(n-1))
    ####################
	j F_done


.data
F_label: .asciiz "F: "
M_label: .asciiz "M: "

