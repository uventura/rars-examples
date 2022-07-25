# Not Optimized version :p
.text
	# Block 1
	li a0, 2	# Block Line
	li a1, 2	# Block Col
	li a2, 7	# Red Color
	jal PRINT_BLOCK
	
	# Block 2
	li a0, 1	# Block Line
	li a1, 1	# Block Col
	li a2, 65	# Another random color
	jal PRINT_BLOCK
	
	# Exit
	li a7, 10
	ecall
	
#=============================+
#         PRINT BLOCK	      |
#=============================+

PRINT_BLOCK: # (a0 => Block Line, a1 => Block Col, a2 => Color)
	# Width = 16, Height = 16
	mv t0, a0			# t0 = Block Line => Line where the block will be putted
	mv t1, a1			# t1 = Block Col => Col where the block will be putted
	mv t2, a2			# t2 = color
	
	li t3, 0			# t3 = Line Counter
	li t4, 0			# t4 = Col Counter
	
	# t5 = Current Address	(Where store the color)
	
NEW_BLOCK_LINE:
	# Next Line Address = 0XFF000000 + 320.LineCounter + Block_Col * width + 320 * Block_Line * height
	# Next Line Address = 0XFF000000 + 320.(lineCounter + Block_Line * height) + Block_Col * width
	
	# 320.(lineCounter + Block_Line * height)
	li t5, 16
	mul t5, t5, t0	# Block_Line * height
	add t5, t5, t3	# t5 = lineCounter + Block_Line * height
	li t6, 320
	mul t5, t5, t6	# t5 *= 320
	
	# Block_Col * Width
	li t6, 16
	mul t6, t6, t1
	
	# Next Line Address
	add t5, t5, t6			# t5 = 320.LineCounter + Block_Col * width
	li t6, 0xFF000000		# t6 = 0xFF000000
	add t5, t5, t6			# t5 += 0xFF000000

NEXT_BLOCK_COL:
	sb t2, 0(t5)
	addi t5, t5, 1			# Next Address
	addi t4, t4, 1			# Next Col
	li t6, 16	
	bne t4, t6, NEXT_BLOCK_COL	# if col != 16 => NEXT_BLOCK_COL
	
	addi t3, t3, 1			# Next Line
	li t4, 0			# Reset Col Counter
	bne t3, t6, NEW_BLOCK_LINE	# If line != 16 => NEXT_BLOCK_LINE
	
	ret
