.data
	matrix1: 	.word 1, 2, 3, 4
	 			.word 5, 6, 7, 8
				.word 9, 10, 11, 12
	 			.word 13, 14, 15, 16
	 
	 
	matrix2: 	.word 0, 0, 0, 0
				.word 0, 0, 0, 0
				.word 0, 0, 0, 0
				.word 0, 0, 0, 0	 
	 
	RowLen:		.word 4
	ColLen: 	.word 4
	
.eqv 	dataSize 4

.text

.globl main
	main:
		la $a1, matrix1
		la $a2, matrix2	

		lw $s1, RowLen
		lw $s2, ColLen

		lui $t1, 0 #i
		lui $t2, 0 #j
		jal transposeFunc
		end: nop
			beq $zero, $zero, end	
   					
###########################################
	transposeFunc:
	
		slt $at,$t1,$s1
		beq $at,$zero exitTranspose
		
		innerLoopTrans:
		
			slt $at,$t2,$s2
			beq $at,$zero exitInnerTrans
				
			mul $t3, $t1, $s2
			add $t3, $t3, $t2
			mul $t3, $t3, dataSize
			add $t3, $t3, $a1		# t3 has address of Matrix1 [i] [j]
			
			lw $t5, ($t3)
			
			mul $t4, $t2, $s1
			add $t4, $t4, $t1
			mul $t4, $t4, dataSize
			add $t4, $t4, $a2		# t4 has address of Matrix2 [j] [i]
				
			sw $t5, ($t4)			# Matrix2 [j] [i] = Matrix1 [i] [j]
				
			addi $t2, $t2, 1
				
			j innerLoopTrans
				
		exitInnerTrans:
			lui $t2, 0
			addi $t1, $t1, 1
			j transposeFunc
					
		exitTranspose:
			lui $t1,0
			lui $t2,0
					
			jr $ra
