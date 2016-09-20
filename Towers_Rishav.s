# towers.s - Solve the Towers of Hanoi puzzle.
# Print each move and return the total number
# of moves needed to solve the puzzle.
#
# Author:	Chris Nevison	1997/09/22
# Revised:	Tom Parks	2002/09/27

# Student:	Your Name	Date

.text 
.globl towers 

# Preconditions:	
#   1st parameter (a0) numDiscs, number of discs to move
#   2nd parameter (a1) start, starting peg
#   3rd parameter (a2) goal, ending peg
# Postconditions:
#   result (v0) steps, total number of steps required to solve puzzle

towers:        addi $sp,$sp,-24	# make space on stack
	sw $s0,0($sp)
	sw $s1,4($sp)		# preserve registers used by this function
	sw $ra,8($sp)		# preserve return address
	sw $s3,12($sp)
	sw $s4,16($sp)
	sw $s5,20($sp)
	
	add $s3,$a0,$zero
	add $s4,$a1,$zero
	add $s5,$a2,$zero
																	
if:	slti $t1,$s3,2		# numDiscs < 2
	beq $t1,$zero,else	# if not, go to else 

	add $a0,$s4,$zero	# 1st parameter = start
	add $a1,$s5,$zero	# 2nd parameter = goal
	jal print		# call print function

	addi $v0,$zero,1	# return value = 1 
	j endif		# jump past else 

else:	addi $s1,$zero,6	# s1 = peg = 6 
	sub $s1,$s1,$s4	# peg = peg - start 
	sub $s1,$s1,$s5	# peg = peg - goal = 6 - start - goal 

	addi $a0,$s3,-1	# 1st parameter = numDiscs - 1
	add $a1, $s4, $zero	# 2nd parameter = start
	add $a2, $s1,$zero	# 3rd parameter = peg
	jal towers		# recursive call to towers 
	add $s0,$v0,$zero	# s0 = steps = result

	addi $a0,$zero,1	# 1st parameter = 1
	add $a1,$s4,$zero	# 2nd parameter = start
	add $a2,$s5,$zero	# 3rd parameter = goal
	jal towers		# recursive call to towers 
	add $s0,$v0,$s0	# steps = steps + result 

	addi $a0,$s3,-1	# 1st parameter = numDiscs - 1
	add $a1,$zero,$s1	# 2nd parameter = peg
	add $a2,$s5,$zero	# 3rd parameter = goal
	jal towers		# recursive call to towers 
	add $v0,$v0,$s0	# return value = steps + result

endif:	lw $s0,0($sp)		# restore registers used by this function
	lw $s1,4($sp)			
	lw $ra,8($sp)	
	lw $s3,12($sp)
	lw $s4,16($sp)
	lw $s5,20($sp)		# restore return address 
	addi $sp,$sp,24	# restore stack pointer

	jr $ra		# return 

# $Id: towers.s,v 1.2 2003/08/29 18:08:50 parks Exp $
