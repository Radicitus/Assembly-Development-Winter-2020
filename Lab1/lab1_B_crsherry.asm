# Cameron Sherry
# crsherry

.globl main
.text
main:

# Prompt user to enter string 
li $v0, 4
la $a0, prompt
syscall

# Store input
li $v0, 8
la $a0, str
li $a1, 5
syscall

# Print str
li $v0, 4
la $a0, endl
syscall
la $a0, str
syscall

# Load first 4 bytes
lw $t0, ($a0)

# Print the str
li $v0, 4
la $a0, endl
syscall
li $v0, 1
move $a0, $t0
syscall

# Print as binary
li $v0, 4
la $a0, endl
syscall
move $a0, $t0
li $v0, 35
syscall

# Print as hex
li $v0, 4
la $a0, endl
syscall
move $a0, $t0
li $v0, 34
syscall

# Add 1 and store
li $t1, 1
add $t0, $t0, $t1
sw $t0, str

# Print str again
li $v0, 4
la $a0, endl
syscall
la $a0, str
syscall

# Place second character into register
lb $t0, 2($a0)

# If statement [NOT CORRECT]
li $v0, 4
la $a0, endl
syscall

andi $t1, $t0 , 1 # odd or even
li $t2, 1
bne $t2, $t1, ODD
la $a0, even
j SYS

ODD:
la $a0, odd

SYS:
syscall


# terminate program
li $v0, 10
syscall



.data
prompt: .asciiz "Enter 4 characters: "
odd: .asciiz "ODD"
even: .asciiz "EVEN"
endl: .asciiz "\n"
.align 2
str: .asciiz "????"

