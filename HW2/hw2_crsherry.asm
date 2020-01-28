# Cameron Sherry
# crsherry

.text

findIndex:
     move $t0, $a0 #Starting address
     move $t1, $a1 #Number of elements
     
     #Initial args check
     li $v0, -1
     li $v1, -1
     blez $t1, findIndexLoopTerminate
     
     li $t2, 0 #Loop counter
     lw $t3, ($t0) #Max Val
     li $t7, 0 #Max Val Index
     lw $t4, ($t0) #Min Val
     li $t8, 0 #Min Val Index
     #Loop to iterate through array
     findIndexLoop:
     beq $t2, $t1, findIndexLoopDone
     
          #Load integer into $t6
          li $t5, 4 #Initialize $t5 with 4 to prep for multiplication
          mul $t5, $t5, $t2 #Multiply by loop counter to get offset
          add $t5, $t5, $t0 
          lw $t6, ($t5)
          
          #Comparison statements
          findIndexLoopMaxVal:
          bge $t3, $t6, findIndexLoopMinVal
          move $t3, $t6
               #Calulate index
               move $t7, $t5
          j findIndexLoopContinue
          
          findIndexLoopMinVal:
          ble $t4, $t6, findIndexLoopContinue
          move $t4, $t6
               #Calculate index
               move $t8, $t5
          j findIndexLoopContinue
          
          #Continue the loop
          findIndexLoopContinue:
          addi $t2, $t2, 1
          j findIndexLoop
          
     #End loop and return values
     findIndexLoopDone:
     move $v0, $t7
     move $v1, $t8

     #Jump back to the program
     findIndexLoopTerminate:
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
