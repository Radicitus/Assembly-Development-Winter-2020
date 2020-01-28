# Your full name
# Netid

.text

findIndex:
     move $t0, $a0 #Starting address
     move $t1, $a1 #Number of elements
     addi $t1, $t1, -1
     
     li $t2, 0 #Loop counter
     li $t3, 0 #Max Val
     li $t4, 0 #Min Val
     #Loop to iterate through array
     findIndexLoop:
     beq $t2, $t1, findIndexLoopDone
     
          #Load integer into $t6
          li $t5, 4 #Initialize $t5 with 4 to prep for multiplication
          mul $t5, $t5, $t2 #Multiply by loop counter to get offset
          lw $t6, $t5 ($t0)
          
          #
     
     
     #Jump back to the program
     jr $ra

maxCharFreq:
    # your code goes here
    li $v0, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    li $v1, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    jr $ra

countAllChars:
    # your code goes here
    li $v0, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    li $v1, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    jr $ra

createHist:
    # your code goes here
    li $v0, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    jr $ra

split:
    # your code goes here
    li $v0, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    li $v1, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    jr $ra
