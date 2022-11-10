.data 
	multMessage: .asciiz "Enter 2 numbers:\n"
	facMessage: .asciiz "Enter 1 number: "
	
.text
	main:
		jal localFac
		move $a0, $v0
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
		
	localMult:
		li $v0,4
		la $a0, multMessage
		syscall
		
		li $v0, 5
		syscall
		move $a1, $v0
		
		li $v0, 5
		syscall
		move $a2, $v0
		
		subu $sp, $sp, 4
		sw $ra, ($sp)
		
		li $v0, 0
		
		jal multiplication
		
		lw $ra, 0($sp)
		addu $sp, $sp, 4
		
		jr $ra
		
	multiplication:
		subu $sp, $sp, 4
		sw $ra, ($sp)
		
		beq $a2, 0, endMult
		
		sub $a2, $a2, 1
		
		jal multiplication
		
		add $v0, $v0, $a1
	
	endMult:
		lw $ra, ($sp)
		addu $sp, $sp, 4
		
		jr $ra
		
	localFac:
		li $v0, 4
		la $a0, facMessage
		syscall
		
		li $v0, 5
		syscall
		move $a1, $v0
		move $a2, $v0
		
		beq $a1, 0, facOfZeroOrOne
		beq $a1, 1, facOfZeroOrOne
		
		subu $sp, $sp, 4
		sw $ra, ($sp)
		
		li $v0, 1
		jal fac
		
		lw $ra, 0($sp)
		addu $sp, $sp, 4
		
		jr $ra
		
	fac:
		subu $sp, $sp, 8
		sw $ra, ($sp)
		sw $a1, 4($sp)
		
		beq $a2, 1, facDone
		move $a1, $a2
		
		subu $a2, $a2, 1
		jal fac
	
		subu $sp, $sp, 4
		sw $ra, ($sp)
		
		move $a2, $a1
		sub $a2, $a2, 1
		move $a1, $v0
		#sub $a2, $a2, 1
		
		jal multiplication
	
		lw $ra, ($sp)
		addu $sp, $sp, 4
	
		facDone:
			lw $ra, ($sp)
			lw $a1, 4($sp)
			addu $sp, $sp, 8
		
			jr $ra
	
	facOfZeroOrOne:
		li $v0, 1
		addi $a0, $zero, 1
		syscall
		
		li $v0, 10
		syscall
