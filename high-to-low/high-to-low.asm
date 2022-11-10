.text
	main:

  	li $v0, 5
    	syscall
    	move $a0, $v0
    
    	jal localFac
    
    	move $a0, $v0
    	li $v0, 1
    	syscall
    
    	li $v0, 10
    	syscall
    

	localMult:
    		move $t0, $zero
   		move $t1, $zero

    		multiplication:
       			add $t1, $t1, $a1
       			addi $t0, $t0, 1 
        		slt $t3, $t0, $a0
        		beq $t3, 1 multiplication
        		nop

    	move $v0, $t1
    	jr $ra

	localFac:
    		move $s0, $a0
    		li $s1, 1
   
    		Fac:
      			move $a0, $s1
        		move $a1, $s0
        
        		subu $sp,$sp,4
        		sw $ra, ($sp)
        
        		jal localMult
        
        		lw $ra, ($sp)
        		addu $sp,$sp,4
        
        		move $s1, $v0 
        		subi $s0, $s0, 1
        		bne $s0, 1, Fac
        		nop
        
    	move $v0, $s1
    	jr $ra
        
    