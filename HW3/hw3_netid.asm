# Cameron Sherry
# crsherry

.include "hw3_helpers.asm"

.text

##############################
# PART 1 FUNCTIONS
##############################

decodedLength:
    
    #EPILOUGUE START#
    
    addi $sp, $sp, -20
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $s3, 12($sp)
    sw $ra, 16($sp)
    
    #EPILOGUE END#    
   
    move $s0, $a0 #Store encoded string address
    move $s1, $a1 #Store symbol flag
    
    #Flag Validation
    beq $s1, 33, decodedLengthLoopValidFlag
    beq $s1, 64, decodedLengthLoopValidFlag
    beq $s1, 35, decodedLengthLoopValidFlag
    beq $s1, 36, decodedLengthLoopValidFlag
    beq $s1, 37, decodedLengthLoopValidFlag
    beq $s1, 94, decodedLengthLoopValidFlag
    beq $s1, 38, decodedLengthLoopValidFlag
    beq $s1, 42, decodedLengthLoopValidFlag
    j decodedLengthLoopDoneFalseFlag
    
    decodedLengthLoopValidFlag:
    li $s2, 0 #Counter for length
    li $s3, 0 #Bool for symbol flag
    decodedLengthLoop:
         lb $t0, ($s0) #Check if null terminator
         beqz $t0, decodedLengthLoopDone
         
         move $a0, $s0 #Load address
         jal atoui
         beqz $v0, decodedLengthLoopChar
              addi $s2, $s2, -2 #Account for flag and character
              add $s2, $s2, $v0 #Add decoded string
              addi $s3, $s3, 1 #Set sym flag exists to true
              
              bgt $v0, 9, decodedLengthLoopCodeGTE10
              decodedLengthLoopCodeLT10:
                   addi $s0, $s0, 1
                   j decodedLengthLoop
                   
              decodedLengthLoopCodeGTE10:
                   
                   addi $s0, $s0, 2
                   j decodedLengthLoop
         
         decodedLengthLoopChar:
              addi $s2, $s2, 1
              addi $s0, $s0, 1
              j decodedLengthLoop
         
         decodedLengthLoopDone:
              beqz $s3, decodedLengthLoopDoneFalseFlag
                   decodedLengthLoopDoneTrueFlag:
                        addi $s2, $s2, 1
                        move $v0, $s2
                        j decodedLengthRestore
              
                   decodedLengthLoopDoneFalseFlag:
                        li $v0, 0
                        j decodedLengthRestore
    
    decodedLengthRestore:
    
    #PROLOUGUE START#
    
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20
    
    #PROLOGUE END# 

    jr $ra

decodeRun:

    #EPILOUGUE START#
    
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $ra, 12($sp)
    
    #EPILOGUE END# 

    move $s0, $a0 #Store character
    move $s1, $a1 #Store length
    move $s2, $a2 #Store starting address of run
    
    #Length and Letter Validation
    blez $s1, decodeRunInvalidArgs
    blt $s0, 65, decodeRunInvalidArgs
    bgt $s0, 122, decodeRunInvalidArgs
    bgt $s0, 90, decodeRunCheckLower
    j decodeRunLoop
    decodeRunCheckLower:
         blt $s0, 97, decodeRunInvalidArgs
    
    li $t0, 0 #Counter
    decodeRunLoop:
         beq $t0, $s1, decodeRunLoopDone
         sb $s0, ($s2)
         addi $s2, $s2, 1 #Increment address
         addi $t0, $t0, 1 #Increment counter
         j decodeRunLoop
         
    decodeRunLoopDone:
         move $v0, $s2
         li $v1, 1
         j decodeRunRestore

    decodeRunInvalidArgs:
         move $v0, $s2
         li $v1, 0
         j decodeRunRestore
      
    decodeRunRestore:
     
    #PROLOUGUE START#
    
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    
    #PROLOGUE END# 

    jr $ra

runLengthDecode:
    
    #EPILOUGUE START#
    
    addi $sp, $sp, -16
    sw $s0, 0($sp)
    sw $s1, 4($sp)
    sw $s2, 8($sp)
    sw $ra, 12($sp)
    
    #EPILOGUE END# 


     


    #PROLOUGUE START#
    
    lw $s0, 0($sp)
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    
    #PROLOGUE END# 

    jr $ra


##############################
# PART 2 FUNCTIONS
##############################

encodedLength:
    #Define your code here
    li $v0, 277

    jr $ra

encodeRun:
    #Define your code here
    li $v0, 277
    li $v1, 277

    jr $ra

runLengthEncode:
    #Define your code here
    li $v0, 277

    jr $ra

##############################
# PART 3 FUNCTION
##############################

editDistance:
    #Define your code here
    li $v0, 277

    jr $ra





