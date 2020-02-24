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
    add $s1, $zero, $zero    #sets x to 0
    addi $t0, $zero, 5      #sets i to 5

Loop:
    slti $t1, $s1, 10       #if x<10, set temporary $t1 to 1, otherwise set it to 0
    beq $t1, $zero, Exit    #if $t1 is 0, jump to exit
    addi $s1, $s1, 2        #increases x by 2
    addi $t0, $t0, -1       #decreases i by 1
    j Loop                  #jumps to Loop label

Exit:
    add $a0, $t0, $zero     #sets $a0 to x to be printed
    addi $v0, $zero, 1      #Sets $v0 to "1" to select print integer syscall
	syscall                 #prints value at $v0 as an integer

	addi $v0, $zero, 10     # Sets $v0 to "10" to select exit syscall
	syscall                 # Exit


	# All memory structures are placed after the
	# .data assembler directive
	.data