# Cameron Sherry
# crsherry
.include "lab2_A_crsherry.asm"

.data
basek_num: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"   
value: .word 0
k: .word 0
value_prompt: .asciiz "Enter Value: "
base_prompt: .asciiz "Enter Base: "
value_string: .asciiz "Value "
base_string: .asciiz " in Base-"
is_string: .asciiz " is "


.text
.globl main
main:

    # print string
    li $v0, 4
    la $a0, value_prompt
    syscall

    # user input integer
    li $v0, 5
    syscall

    # Store user value in memory at label value
    la $t0, value
    sw $v0, 0($t0) 

    # print string
    li $v0, 4
    la $a0, base_prompt
    syscall

    # user input integer
    li $v0, 5
    syscall

    # Store user value in memory at label k
    la $t0, k
    sw $v0, 0($t0) 

    ##########################
    # Start your code here
    ##########################

li $s0, 19 #position counter
la $s1, basek_num
lw $s2, value
#Load base k into args1 register
lw $a1, k

loop:
beqz $s2, Done
#Load value into args0 register
move $a0, $s2
#Base k function
jal BasekDigit
#Overwrite Value with new value
move $s2, $v0
#Add digit to array
add $s3, $s1, $s0 
sb $v1, ($s3)
#Subtract one from position counter
addi $s0, $s0, -1
j loop

Done:
li $v0, 4
la $a0, value_string
syscall
li $v0, 1
lw $a0, value
syscall
li $v0, 4
la $a0, base_string
syscall
li $v0, 1
lw $a0, k
syscall
li $v0, 4
la $a0, is_string
syscall
li $v0, 4
move $a0, $s3
#Print Newline
syscall
la $a0, newline
syscall

#COMPLETE
COMPLETE:
li $v0, 10
syscall



