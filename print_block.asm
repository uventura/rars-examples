# Dumb Version :D

.text
li t0, 0xFF000000
li t1, 7
li t2, 0			# Counter of Rows
li t3, 20			# Counter of Cols

NEW_LINE:
	# Next Line Address = 0XFF000000 + 320.line
	li t5, 320
	mul t5, t5, t2		# 320 * line
	
	li t0, 0xFF000000	
	add t0, t0, t5		# Next Line Address
NEW_COL:
	sb t1, 0(t0)
	addi t0, t0, 1
	addi t3, t3, -1
	bnez t3, NEW_COL
	
	addi t2, t2, 1		# Next Line
	li t3, 20		# Reset Col
	
	li t6, 20		# Temporary Variable
	bne t2, t6, NEW_LINE	# if t2 != 20
li a7, 10
ecall