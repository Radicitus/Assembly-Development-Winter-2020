.include "lab3_B_crsherry.asm"
.include "lab3_C_crsherry.asm"
.include "lab3_functions_crsherry.asm"

.globl main
.text
main:

	li $v0, 4
	la $a0, stat1
	syscall

	li $v0, 1
	la $t0, n
	lw $a0, 0($t0)
	syscall

	li $v0, 4
	la $a0, stat2
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall 

	li $s0, 0   # i counter
	la $s2, strings # strings[]
	la $s7, n
	lw $s7, 0($s7)  # n

printStr:
	bge $s0, $s7, process
	sll $t7, $s0, 2
	add $t8, $t7, $s2

	li $v0, 4
	la $a0, qoute
	syscall
	lw $a0, 0($t8)	  # strings[i]
	syscall
	la $a0, qoute
	syscall
	la $a0, endl
	syscall 
	addi $s0, $s0, 1
	j printStr

process:
	move $a0, $s2
	move $a1, $s7
	jal processStrings

	li $v0, 4
	la $a0, stat1
	syscall

	li $v0, 1
	la $t0, n
	lw $a0, 0($t0)
	addi $a0, $a0, 1
	syscall

	li $v0, 4
	la $a0, stat2
	syscall
	
	li $v0, 4
	la $a0, endl
	syscall 

	li $s0, 0   # i counter
	la $s2, strings2 # strings[]
	la $s7, n
	lw $s7, 0($s7)  # n
	addi $s7, $s7, 1

printStr2:
	bge $s0, $s7, process2
	sll $t7, $s0, 2
	add $t8, $t7, $s2

	li $v0, 4
	la $a0, qoute
	syscall
	lw $a0, 0($t8)	  # strings[i]
	syscall
	la $a0, qoute
	syscall
	la $a0, endl
	syscall 
	addi $s0, $s0, 1
	j printStr2

process2:
	move $a0, $s2
	move $a1, $s7
	jal processStrings

	li $v0, 10
	syscall

.data
strings: .word str_1, str_2, str_3, str_4
strings2: .word str_xyz, str_world, str_123, str_bar, str_help
n: .word 4

str_1: .asciiz "lower case letters should not be detected and the function should only process the spaces"
str_bar: .asciiz ""
str_2: .asciiz "!!$%@&()(!))//%@$...,,,>>>"
str_world: .asciiz ""
str_3: .asciiz "THEY SAY THAT DOGS ARE MAN'S BEST FRIEND... BUT, THIS CAT WAS SETTING OUT TO SABOTAGE THAT THEORY.  >> FROM: RANDOM@MAIL.COM"
str_xyz: .asciiz ""
str_123: .asciiz ""
str_4: .asciiz "HOWRAZORBACKJUMPINGFROGSCANLEVELSIXPIQUEDGYMNASTS"
str_help: .asciiz ""



stat1: .asciiz "There are "
stat2: .asciiz " strings in the array.\nThe strings are "
qoute: .asciiz "\""
endl: .asciiz "\n"
