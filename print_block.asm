# Dumb Version :D

.text
li t0, 0xFF000000
li t1, 7					# Color
li t2, 0					# Rows Counter
li t3, 20					# Cols Counter

NEW_LINE:
	# Next_Line_Address = 0XFF000000 + 320.line
	li t5, 320
	mul t5, t5, t2				# 320 * line
	
	li t0, 0xFF000000			# Frame Address
	add t0, t0, t5				# Next Line Address
NEW_COL:
	sb t1, 0(t0)				# Store Color into Address
	addi t0, t0, 1				# New Address
	addi t3, t3, -1				# Cols Counter Update
	bnez t3, NEW_COL			# if Cols_Counter != 0 => NEW_COL
	
	addi t2, t2, 1				# Next Line
	li t3, 20				# Reset Col
	
	li t6, 20				# Temporary Variable
	bne t2, t6, NEW_LINE			# if t2 != 20
	
# Exit
li a7, 10
ecall

# Changes that you can make:
# If you're working with blocks that are divisible by 4, instead of using "sb ..."
# you can use "sw ...", because this operation uses 4 bytes instead of 1 byte at time.
