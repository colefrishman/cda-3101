# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point

#x is strored in $s0
#i is strored in $t0
main:
    addi $s1, $zero, 20     #sets x to 20
    addi $s2, $zero, 1      #sets y to 1


    addi $t0, $zero, 1      #sets i to 1
    addi $t2, $zero, 4      #sets $t2 to 4 for later comparisons
    addi $t3, $zero, 5      #sets $t3 to 5 for later comparisons
Loop:
    bge $t0, $t2 Exit       #jumps to exit if i>4
    addi $t1, $zero, 3      #stores constant 3 in $t1 for later use
    mult $t1, $t0           #multiplies i by 3 and stores in $LO
    mflo $t1                #moves 3*i from $lo to $t1
    sub $s1, $s1, $t1       #decreases x by 3*i
    addi $s2, $s2, 1        #increases y by 1

    addi $t0, $t0, 1        #increases i by 1
    ble $s2, $t3, Loop      #jumps to loop if y<5
    jal LoopPrint           #jumps to LoopPrint and links back to the next line of code
    j Loop                  #jumps to Loop label

Exit:

    addi $v0, $zero, 4      #Sets $v0 to "4" to select print string syscall
    la $a0, endtext         #sets $a0 to endtext to be printed
	syscall                 #prints value at address at $a0 as a string
    add $a0, $s2, $zero     #sets $a0 to x to be printed
    addi $v0, $zero, 1      #Sets $v0 to "1" to select print integer syscall
	syscall                 #prints value at $a0 as an integer

	addi $v0, $zero, 10     # Sets $v0 to "10" to select exit syscall
	syscall                 # Exit

LoopPrint:
    addi $v0, $zero, 4      #Sets $v0 to "4" to select print string syscall
    la $a0, looptext        #sets $a0 to looptext to be printed
	syscall                 #prints value at address at $a0 as a string
    add $a0, $s2, $zero     #sets $a0 to x to be printed
    addi $v0, $zero, 1      #Sets $v0 to "1" to select print integer syscall
	syscall                 #prints value at $a0 as an integer
    jr $ra                  #jumps to code at $ra


	# All memory structures are placed after the
	# .data assembler directive
	.data
    endtext: .asciiz      "\nEnding y = "       #text to be used at the end
    looptext: .asciiz      "\nIn-loop y = "     #text to be used in the loop