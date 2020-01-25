# Cameron Sherry
# crsherry

.globl main
.text
main:

# print prompt
li $v0, 4
la $a0, prompt
syscall

# read user input (int)
li $v0, 5
syscall

#add value to input
lw $s0, num
add $s0, $s0, $v0

# print value on new line
li $v0, 1
move $a0, $s0
syscall
li $v0, 4
la $a0, endl
syscall

# negate value and and store
neg $s0, $s0
sw $s0, value

# print value label
li $v0, 1
move $a0, $s0
syscall

# print character array abcd
li $v0, 4
la $a0, endl
syscall
li $v0, 4
la $a0, abcd
syscall

# shift value by 8 bits
li $v0, 4
la $a0, endl
syscall
sll $s0,$s0,8
li $v0, 1
move $a0, $s0
syscall

# store shifted value
sw $s0, value

# print abcd again
li $v0, 4
la $a0, endl
syscall
li $v0, 4
la $a0, abcd
syscall
li $v0, 4
la $a0, endl
syscall

# terminate program
li $v0, 10
syscall

.data
num: .word 2010 # an integer
prompt: .asciiz "Enter an integer:"  # a string
endl: .asciiz "\n"   # a string
.align 2
abcd: .ascii "ABCD"  # 4-character array
value: .word -100    # an integer
moreabcs: .asciiz "EFGHIJK"  # a string
