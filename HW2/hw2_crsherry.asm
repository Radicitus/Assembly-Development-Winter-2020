# Cameron Sherry
# crsherry

.text

findIndex:
     move $t0, $a0 #Starting address
     move $t1, $a1 #Number of elements
     
     #Initial args check
     li $v0, -1
     li $v1, -1
     blez $t1, findIndexTerminate
     
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
     findIndexTerminate:
     jr $ra

maxCharFreq:
     move $t0, $a0 #Address of string
     
     move $t1, $t0 #Address being checked
     li $t2, 0 #Char of highest frequency
     li $t3, 0 #Frequency counter
     move $t4, $t0 #Incremented address
     
     #Loop to iterate through string
     maxCharFreqLoop:
          #Initialize loop local counter vars
          li $t5, 0 #Loop local frequency count
          li $t6, 0 #Loop local char value
     
          #Load character
          lb $t6, ($t4)
          
          #Check if null terminator
          beq $t6, 0, maxCharFreqDone
          addi $t5, $t5, 1
          
          #Create a new inner loop
          move $t7, $t4
          maxCharFreqLoopInner:
          	#Increment address
               addi $t7, $t7, 1
               lb $t8, ($t7) #Inner loop char value
               
               #Check if null terminator
               beqz $t8, maxCharFreqLoopInnerDone
               
               #Comparison statements
               bne $t6, $t8, maxCharFreqLoopInner
               addi $t5, $t5, 1
               j maxCharFreqLoopInner
               
               #Save frequency counts and character
               maxCharFreqLoopInnerDone:
               ble $t5, $t3, maxCharFreqLoopContinue
               move $t3, $t5
               move $t2, $t6
               j maxCharFreqLoopContinue
               
          #Continue the loop
          maxCharFreqLoopContinue:
          addi $t4, $t4, 1
          j maxCharFreqLoop        
     
     #Check if an error has occurred and assign values    
     maxCharFreqDone:
     beqz $t3, maxCharFreqError
     move $v0, $t2
     move $v1, $t3
     j maxCharFreqTerminate
     
     #Assign error values
     maxCharFreqError:
     li $v0, -1
     li $v1, -1
     j maxCharFreqTerminate
     
     #Jump back to the program
     maxCharFreqTerminate:
     jr $ra

countAllChars:
    move $t0, $a0 #String address
    move $t1, $a1 #Array address
    
    #Initialize counter vars
    li $t2, 0 #Number of space char
    li $t3, 0 #Number of alpha char
    
    #Zero out the array
    li $t7, 0 #Index counter
    countAllCharsZeroLoop:
         #Check if index is out of range
         beq $t7, 104, countAllCharsLoop
              add $t8, $t7, $t1 #Address of index
              sw $0, ($t8) #Zero out address
              addi $t7, $t7, 4 #Increment index xounter by 4
         j countAllCharsZeroLoop
    		
    #Loop to iterate through string
    countAllCharsLoop:
         #Load char value
         lb $t4, ($t0) 
         
         #Check if null terminator
         beqz $t4, countAllCharsDone
         
         #ASCII decimal comparisons
              #Check if space char
              beq $t4, 32, countAllCharsLoopSpace
              
              #Check if outside alpha char bounds, <65
              blt $t4, 65, countAllCharsLoopContinue
              
              #Check if outside alpha char bounds, >122
              bgt $t4, 122, countAllCharsLoopContinue
              
              #Check if within alpha char bounds, <91
              blt $t4, 91, countAllCharsLoopIndexConversionUpper
              
              #Check if within alpha char bounds, >96
              bgt $t4, 96, countAllCharsLoopIndexConversionLower
              
              #Space Char!
              countAllCharsLoopSpace:
              addi $t2, $t2, 1
              j countAllCharsLoopContinue
              
         #Alphabet conversion operations
              #Upper conversion
              countAllCharsLoopIndexConversionUpper:
              addi $t4, $t4, -65
              j countAllCharsLoopIndexConversion
              #Lower conversion
              countAllCharsLoopIndexConversionLower:
              addi $t4, $t4, -97
              j countAllCharsLoopIndexConversion
              
              #Conversion to index
              countAllCharsLoopIndexConversion:
              #Increment alpha counter
              addi $t3, $t3, 1
              #Reduce value in decimal to an address offset
              add $t4, $t4, $t1 #Now an address to the index
              #Increment appropriate array index
              lw $t5, ($t4)
              addi $t5, $t5, 1
              sw $t5, ($t4)
              #Continue loop
              j countAllCharsLoopContinue
	      
	 #Continue loop
	 countAllCharsLoopContinue:
	 addi $t0, $t0, 1
	 j countAllCharsLoop
	 
     #Complete function
     countAllCharsDone:
     move $v0, $t2
     move $v1, $t3
     
     #Jump back to the program
     jr $ra

createHist:
    move $t0, $a0
    
    #Initial for loop to see if there's a negative value
    move $t1, $t0
    li $t8, 0 #Non-zero array entries counter
    li $t9, 0 #Index counter
    createHistNegCheckLoop:
         #Load value
         lw $t2, ($t1)
         
         #Check if loop complete
         beq $t9, 26, createHistLoopInit
         
         #Check if negative value
         bltz $t2, createHistError
         
         #Continue loop
         addi $t1, $t1, 4 #Increment value address
         addi $t9, $t9, 1 #Increment index counter
         j createHistNegCheckLoop

     #Error handling
     createHistError:
          #Assign return values
          li $v0, -1
          #Jump to program termination
          j createHistTerminate

     #Main loop for creating the histogram
     createHistLoopInit:
     move $t1, $t0
     li $t9, 0 #Index counter
     createHistLoop:
          #Load value
          lw $t2, ($t1)
          
          #Check if loop complete
          beq $t9, 26, createHistDone
          
          #Check if value equal to zero, then print histogram
          beqz $t2, createHistLoopIndexIncr
               #Convert index to ASCII char
               addi $t4, $t9, 97
               #Increment non-zero counter
               addi $t8, $t8, 1
               #Print character and colon
               li $v0, 11
               move $a0, $t4
               syscall
               li $a0, 58
               syscall
               
               #Initialize loop local counter
               li $t3, 0
               #Begin loop for printing histogram
               createHistLoopInner:
                    #Check if range exceeded
                    beq $t3, $t2, createHistLoopInnerDone
                    #Print a star
                    li $a0, 42
                    syscall
                    #Increment local loop counter
                    addi $t3, $t3, 1
                    #Jump back to loop
                    j createHistLoopInner
               
               #Complete printing of histogram for character
               createHistLoopInnerDone:
                    #Print new line
                    li $a0, 10
                    syscall
                    
               #Increment index counter
               createHistLoopIndexIncr:
                    addi $t9, $t9, 1
                    addi $t1, $t1, 4
                    j createHistLoop

     #Assign values and terminate function
     createHistDone:
          #Assign to return register
          move $v0, $t8
     
     #Terminate the function
     createHistTerminate:
          #Jump back to program
          jr $ra
          
split:
    # your code goes here
    li $v0, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    li $v1, 495   # REMOVE THIS LINE, ONLY FOR ASSEMBLY WITH MAIN
    jr $ra
