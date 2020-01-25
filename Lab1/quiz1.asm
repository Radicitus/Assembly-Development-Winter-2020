.data
array: .word 9,8,7,6,5,4,3,2,1,0

.text
li $t0, 60
li $t1, -2
li $t2, 777
la $s0, array
sw $t2, 4($s0)