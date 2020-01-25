# Cameron Sherry
# crsherry

.data
newline: .asciiz "\n"
Error: .asciiz "Value must be > 0. Base must be in the range [1,16]\n"
Quotient_string: .asciiz "Quotient is "
Remainder_string: .asciiz ", Remainder is "

.text
BasekDigit:

#Move argument values to temporary registers
#move $a0, $t0 #value
#move $a1, $t1 #k

#Initial check for valid args
bgt $a1, 16, ARGSERROR
blt $a1, 1, ARGSERROR
blez $a0, ARGSERROR

#Divide value by k
div $a0, $a1
     #Assign quotient and remainder to registers
     mfhi $t0 #remainder
     mflo $t1 #quotient
     
#Print statement for Q and R
     #Print Quotient
     li $v0, 4
     la $a0, Quotient_string
     syscall
     li $v0, 1
     move $a0, $t1
     syscall
     #Print Remainder
     li $v0, 4
     la $a0, Remainder_string
     syscall
     li $v0, 1
     move $a0, $t0
     syscall
     #Print newline
     li $v0, 4
     la $a0, newline
     syscall

#Switch for remainder char value
case15:
     bne $t0, 15, case14 
     move $v0, $t1
     li $v1, 'F'
     j DONE
case14:
     bne $t0, 14, case13 
     move $v0, $t1
     li $v1, 'E'
     j DONE
case13:
     bne $t0, 13, case12 
     move $v0, $t1
     li $v1, 'D'
     j DONE
case12:
     bne $t0, 12, case11
     move $v0, $t1
     li $v1, 'C'
     j DONE
case11:
     bne $t0, 11, case10
     move $v0, $t1
     li $v1, 'B'
     j DONE
case10:
     bne $t0, 10, default
     move $v0, $t1
     li $v1, 'A'
     j DONE
default:
     move $v0, $t1
     addi $v1, $t0, 48
     j DONE

#ARGSERROR
ARGSERROR:
li $v0, 4
la $a0, Error
syscall

#TERMINATE
TERMINATE:
li $v0, 10
syscall

#Function has completed task
DONE:
jr $ra








