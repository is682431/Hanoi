 .data
 
 .text
 	addi $s0, $zero, 8		# number of disks n.
 	
 	# reserve memory starting on 10010000 as instrcuted on the file, this is where the disks will be loaded.
	addi $s1, $zero, 0x1001		# \
	sll $s1, $s1, 16		# Loading A rod direction.
	ori $s1, $s1, 0x0000		#/
	
	addi $s2, $zero, 0x1001		# \
	sll $s2, $s2, 16		# Loading B rod direction.
	ori $s2, $s2, 0x0080		#/
	
	addi $s3, $zero, 0x1001		# \
	sll $s3, $s3, 16		# Loading C rod direction.
	ori $s3, $s3, 0x0100		#/
	
	addi $s4, $zero, 1		# Place 1 in a s1 for use in comparations.
	
	add $a0, $s1, $zero		# Loading arguments for fillA function.
	add $a1, $s0, $zero		#/
	jal fillA			# Call fillA.
	
	add $s1, $v0, $zero		# Replacing the value of the rod A direction with the new one.
	
	add $a0, $s0, $zero		# \
	add $a1, $zero, $s1		# Loading arguments for Hanoi function.
	add $a2, $zero, $s2		# |
	add $a3, $zero, $s3		#/
	jal Hanoi			# Call Hanoi function.
	
	j Exit
	
# fillA function fills A rod with n disks, where a1 = number of disks and a0 = Memory direction of the A rod.
fillA:	sw $a1, 0($a0)			# store n, n-1, n-2, n-3, on A.
	addi $a1, $a1, -1		# n-1
	addi $a0, $a0, 4		# move to next space on memory.
	bne $a1, $zero, fillA		# if n != 0 return to fillrod until all disks are stored on rod.
	add $v0, $a0, $zero		# Returning the direction of the last disk in the rod A.
	jr $ra

# Hanoi function, where a0 = number of disks, a1 = Initial rod, a2 = temporal rod and a3 = final rod.
Hanoi:	bne $a0, $zero, Safe		# Case where n = 0.
	jr $ra
Safe:	bne $a0, $s4, if		# Case where n = 1.
	addi $a1, $a1, -4
	lw $t0, 0($a1)			#\
	sw $zero, 0($a1)		# Move disk
	sw $t0, 0($a3)			# |
	add $v0, $zero, $zero		# |
	addi $v1, $zero, 4		#/
	jr $ra
if:	addi $sp, $sp, -20		# Reserve space in stack
	sw $a0, 0($sp)			#\
	sw $a1, 4($sp)			# |
	sw $a2, 8($sp)			# Save important values
	sw $a3, 12($sp)			# |
	sw $ra, 16($sp)			#/
	addi $a0, $a0, -1		#\
	lw $a2, 12($sp)			# Switch arguments
	lw $a3, 8($sp)			#/
	
	jal Hanoi			# Call Hanoi function
	
	add $a1, $a1, $v0
	add $a3, $a3, $v1
	sw $a1, 4($sp)			# Actualize values
	sw $a3, 8($sp)			#/
	
	lw $a0, 0($sp)			#\
	lw $a1, 4($sp)			# |
	lw $a2, 8($sp)			# Restore important values
	lw $a3, 12($sp)			# |
	lw $ra, 16($sp)			#/
	addi $sp, $sp, 20		# Free space in stack
	
	addi $a1, $a1, -4
	lw $t0, 0($a1)			#\
	sw $zero, 0($a1)		# Move disks
	sw $t0, 0($a3)			# |
	add $a1, $a1, $zero		# |
	addi $a3, $a3, 4		#/
	
	addi $sp, $sp, -20		# Reserve space in stack
	sw $a0, 0($sp)			#\
	sw $a1, 4($sp)			# |
	sw $a2, 8($sp)			# Save important values
	sw $a3, 12($sp)			# |
	sw $ra, 16($sp)			#/
	addi $a0, $a0, -1		#\
	lw $a1, 8($sp)			# |
	lw $a2, 4($sp)			# Switch arguments
	lw $a3, 12($sp)			#/
	
	jal Hanoi
	
	add $a1, $a1, $v0
	add $a3, $a3, $v1
	sw $a1, 8($sp)			# Actualize values
	sw $a3, 12($sp)			#/
	
	lw $a0, 0($sp)			#\
	lw $a1, 4($sp)			# |
	lw $a2, 8($sp)			# Restore important values
	lw $a3, 12($sp)			# |
	lw $ra, 16($sp)			#/
	addi $sp, $sp, 20		# Free space in stack
	
	add $v0, $zero, $zero		# No feedback when reached end of function
	add $v1, $zero, $zero		#/
	
	jr $ra

Exit:
