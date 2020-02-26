# A demonstration of some simple MIPS instructions
# used to test QtSPIM

	# Declare main as a global function
	.globl main 

	# All program code is placed after the
	# .text assembler directive
	.text 		

# The label 'main' represents the starting point

#i is strored in $t0
main:
    la $s3, bumble          #stores the location in memory of the bumble array in $s3
     
    add $t1, $zero, $zero   #initial condition B(0)=0 value stored in $t1
    sw $t1, ($s3)           #stores value of B(0) into bumble[0]
    addi $s3, $s3, 8        #moves address of s3 to next spot in array

    addi $a0, $t1, 0        #sets $a0 to the value of B(0) to be printed
    addi $v0, $zero, 1      #Sets $v0 to "1" to select print integer syscall
	syscall                 #prints value at address at $a0 as an integer
    addi $v0, $zero, 4      #Sets $v0 to "4" to select print string syscall
    la $a0, newline         #sets $a0 to newline text to be printed
	syscall                 #prints value at address at $a0 as a string

    addi $t1, $zero, 1      #initial condition B(1)=1 value stored in $t0
    sw $t1, ($s3)           #stores value of B(1) into bumble[1]
    addi $s3, $s3, 8        #moves address of s3 to next spot in array

    addi $a0, $t1, 0        #sets $a0 to the value of B(1) to be printed
    addi $v0, $zero, 1      #Sets $v0 to "1" to select print integer syscall
	syscall                 #prints value at address at $a0 as an integer
    addi $v0, $zero, 4      #Sets $v0 to "4" to select print string syscall
    la $a0, newline         #sets $a0 to newline text to be printed
	syscall                 #prints value at address at $a0 as a string

    li $t3, 10              #stores constant to be compared against for the loop
    li $t0, 2               #sets i to 2 for initial condition
Loop:
    bgt	$t0, $t3, Exit	    #if i>10 then jump to exit

    lw $t2, -8($s3)         #gets value at B[i-1], stores in $t2
    sll $t2, $t2, 1         #multiplies $t2 by 2

#An overflow will occur for the largest values when using mult and mflo
    lw $t1, -16($s3)        #gets value at B[i-2], stores in $t1
    mult $t1, $t1           #multiplies $t1 by $t1
    mflo $t1                #moves (lower word of) multiplied value into $t1

    add $t1, $t1, $t2       #adds the value of $t1 and $t2 and stores into $t1
    sw $t1, ($s3)           #stores $t1 in array at location B[i]

    addi $a0, $t1, 0        #sets $a0 to the value of B(i) to be printed
    addi $v0, $zero, 1      #Sets $v0 to "1" to select print integer syscall
	syscall                 #prints value at address at $a0 as an integer

    addi $v0, $zero, 4      #Sets $v0 to "4" to select print string syscall
    la $a0, newline         #sets $a0 to newline text to be printed
	syscall                 #prints value at address at $a0 as a string

    addi $t0, $t0, 1        #increments i by 1
    addi $s3, $s3, 8        #increments memory locastion by 8
    j Loop                  #jumps to label Loop

Exit:
	addi $v0, $zero, 10     # Sets $v0 to "10" to select exit syscall
	syscall                 # Exit

	.data
    bumble: .space 88       #leaves 2 words for each of 11 bumble numbers since a long long was needed to store B(10)
    newline: .asciiz "\n"   #newline character for making a nice output