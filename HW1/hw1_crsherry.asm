# Homework 1
# Name: Cameron Sherry
# Net ID: crsherry
.globl main

.data
newline: .asciiz "\n"
err_string: .asciiz "INPUT ERROR"

prompt_type: .asciiz "Random Numbers (r/R) or ASCII string (a/A)? "
prompt_ascii: .asciiz "Enter a ASCII string (max 100 characters): "
prompt_seed: .asciiz "Enter the seed: "
prompt_numbers: .asciiz "How many numbers? "

rand_last: .asciiz "Last value drawn: "
rand_odd: .asciiz "# of Odd: "
rand_power: .asciiz "Power of 2: "
rand_mult: .asciiz "Multiple of 8: "
rand_values: .asciiz "Values <= 512: "

ascii_length: .asciiz "Length of string: "
ascii_space: .asciiz "# of space characters: "
ascii_upper: .asciiz "# of uppercase letters: "
ascii_symbols: .asciiz "# of symbols: "
ascii_pairs: .asciiz "# of character pairs: "

#User added variables
user_ascii_char_string: 
.space 101 
.asciiz

.text

main:

#Prompt User for type of stats
li $v0, 4
la $a0, prompt_type
syscall

#Read character
li $v0, 12
syscall
move $s0, $v0
li $v0, 4
la $a0, newline
syscall

#Verify single character
li $t0, 'a'
li $t1, 'A'
li $t2, 'r'
li $t3, 'R'

beq $s0, $t0, VALIDA
beq $s0, $t1, VALIDA
beq $s0, $t2, VALIDR
beq $s0, $t3, VALIDR

#If string not verified print error message and exit
j TERMINATE

#If valid and a/A, prompt user to enter string and store it
VALIDA:
li $v0, 4
la $a0, prompt_ascii
syscall

li $v0, 8
li $a1, 100
syscall
move $s1, $a0

j ASCII

#If valid and r/R, prompt user to enter seed and store it
VALIDR:
li $v0, 4
la $a0, prompt_seed
syscall
li $v0, 5
syscall
move $s1, $v0

#Prompt user to enter a number, check it, and store it
li $v0, 4
la $a0, prompt_numbers
syscall
li $v0, 5
syscall

blez $v0, TERMINATE
move $s2, $v0

#Configure random number generator
li $v0, 40
li $a0, 1
move $a1, $s1
syscall

#Collect number statistics
li $t0, 0 #Number counter
li $t1, 0 #Odd numbers
li $t2, 0 #Values which are power of two
li $t3, 0 #Numbers which are multiple of eight
li $t4, 0 #Number of values <= 512
li $t5, 1 #

loop:
beq $s2, $t0, done

#Get random value
li $v0, 42
li $a0, 1
li $a1, 1023
syscall
addi $a0, $a0, 1
move $t9, $a0

#Determine if ODD
andi $t6, $a0, 1
bne $t6, $t5, POWER2
addi $t1, $t1, 1 

#Determine if a power of 2
POWER2:
addi $t6, $a0, -1
and $t6, $t6, $a0
bnez $t6, MULT8
addi $t2, $t2, 1

#Determine if multiple of 8
MULT8:
srl $t6, $a0, 3
sll $t6, $t6, 3
bne $t6, $a0, LTE512
addi $t3, $t3, 1

#Determine if less than or equal to 512
LTE512:
bgt $a0, 512, INCRLOOP
addi $t4, $t4, 1

INCRLOOP:
addi $t0, $t0, 1 
j loop
done:

#Print last rand val
li $v0, 4
la $a0, rand_last
syscall
li $v0, 1
move $a0, $t9
syscall

#Print number of ODD
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, rand_odd
syscall
li $v0, 1
move $a0, $t1
syscall

#Print power of 2
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, rand_power
syscall
li $v0, 1
move $a0, $t2
syscall

#Print multiple of 8
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, rand_mult
syscall
li $v0, 1
move $a0, $t3
syscall

#Print less than or equal to 512
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, rand_values
syscall
li $v0, 1
move $a0, $t4
syscall
li $v0, 4
la $a0, newline
syscall

j END

ASCII:
move $t5, $s1

li $t0, -1 #Length of the string
li $t1, 0 #Number of space characters
li $t2, 0 #Number of Uppercase
li $t3, 0 #Number of symbol characters
li $t4, 0 #Number of character pairs

aloop:
#Check if sting is terminated
lb $t6, ($t5)
beqz $t6, adone

#Increment length counter
addi $t0, $t0, 1

#Determine if space character
bne $t6, 0x20, UPPER
addi $t1, $t1, 1

#Determine if Uppercase
UPPER:
blt $t6, 0x41, SYMBOLS
bgt $t6, 0x5A, SYMBOLS
addi $t2, $t2, 1

#Determine if a symbol
SYMBOLS:
blt $t6, 0x21, PAIRS
bgt $t6, 0x7E, PAIRS

ble $t6, 0x2F, ISSYMBOL
blt $t6, 0x3A, PAIRS

ble $t6, 0x40, ISSYMBOL
blt $t6, 0x5B, PAIRS

ble $t6, 0x60, ISSYMBOL
blt $t6, 0x7B, PAIRS

ISSYMBOL:
addi $t3, $t3, 1

#Determine if pairs
PAIRS:
addi $t7, $t5, 1
lb $t7,($t7)
beqz $t7, AINCR
bne $t7, $t6, AINCR
addi $t4, $t4, 1

#Increments string address
AINCR:
addi $t5, $t5, 1
j aloop
adone:

#Print length of string
li $v0, 4
la $a0, ascii_length
syscall
li $v0, 1
move $a0, $t0
syscall

#Print number of spcaes
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, ascii_space
syscall
li $v0, 1
move $a0, $t1
syscall

#Print number of uppercase
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, ascii_upper
syscall
li $v0, 1
move $a0, $t2
syscall

#Print number of symbols
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, ascii_symbols
syscall
li $v0, 1
move $a0, $t3
syscall

#Print number of pairs
li $v0, 4
la $a0, newline
syscall
li $v0, 4
la $a0, ascii_pairs
syscall
li $v0, 1
move $a0, $t4
syscall

j END

#Terminate program
TERMINATE:
li $v0, 4
la $a0, err_string
syscall
li $v0, 10
syscall

#Complete program
END:
li $v0, 10
syscall






