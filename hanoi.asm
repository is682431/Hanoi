.data

.text
					# reserve memory starting on 10010000 as instrcuted on the file, this is where the disks will be loaded
	addi $a1, $zero, 0x10010000	# A
	addi $a2, $zero, 0x10010020	# B
	addi $a3, $zero, 0x10010040	# C
	
	addi $s0, $zero, 1		# number of disks n
	add $t0, $s0, $0		# temp used to loop using n	
fillA:					# fill the first rod with n disk 		
						
	sw $s0, 0($a1)			# store n, n-1, n-2, n-3, on A
	addi $s0, $s0, -1		# n-1
	addi $a1, $a1, 4		# move to next space on memory
	bne $s0, $zero, fillA		# if n != 0 return to fillrod until all disks are stored on rod	 


Hanoi:
	beq $s0, 1, BaseCase

BaseCase:
		
	
	
	
	
	
exit:
