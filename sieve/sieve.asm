##################################################################
#
#   Template for subassignment "Inbyggda System-mastern, här kommer jag!"
#
#   Author: Viola Söderlund <violaso@kth.se>
#
#   Created: 2020-10-25
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Documentation (https://ecs-network.serv.pacific.edu/ecpe-170/tutorials/mips-instruction-set)
#   See: Sieve of Eratosthenes (https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
#
##################################################################

### Data Declaration Section ###

.data

primes:		.space  1000            # reserves a block of 1000 bytes in application memory
err_msg:	.asciiz "Invalid input! Expected integer n, where 1 < n < 1001.\n"
myArray: .word 1:1000
space: .asciiz ", "

### Executable Code Section ###

.text

main:
    # get input
    li      $v0,5                   # set system call code to "read integer"
    syscall                         # read integer from standard input stream to $v0

    # validate input
    li 	    $t0,1001                # $t0 = 1001
    slt	    $t1,$v0,$t0		    # $t1 = input < 1001
    #beq     $t1,$zero,invalid_input # if !(input < 1001), jump to invalid_input
    nop
    li	    $t0,1                   # $t0 = 1
    slt     $t1,$t0,$v0		    # $t1 = 1 < input
    #beq     $t1,$zero,invalid_input # if !(1 < input), jump to invalid_input
    nop
    
    move $s0, $v0
    
    li $t0, 2    # $t0 = 0 (our index counter) p
    move $t1, $s0  # $t1 = 10 (our index limit) n
    li $t3, 0 # pointer
    
    loop2:
    	mul $t4, $t0, $t0 # p*p
    	
    	bgt $t4, $s0,done  # 
    	
    	addi $t7, $t0, 1
    	mul $t3, $t7, 4
    	lw $t2, myArray($t3) # get int[i]
    	

    	beq $t2, 0, bypass # if int[i] == 0 loop
    	
    	subu $sp,$sp,4
    	sw $t4, ($sp)
    	
    		loop3:
    			addi $t7, $t4, 1
    			mul $t3, $t7, 4
    			sw $zero, myArray($t3) #set myArray[i] == 0
    			#lw $s5, myArray($t3) #set myArray[i] == 0
    			
    			#li $v0, 1
    			#move $a0, $s5
    			#syscall
    			
    			blt $t4, $s0, middleThing #if p*p < n -> loop
    			
    			j breakInner
    			
    		#	li $v0, 1
    		#	move $a0, $t4
    		#	syscall
    		middleThing:
    			add $t4, $t4, $t0 # P*P + n
    			j loop3
    			
    	breakInner:		
    	lw $t4, ($sp)
    	addu $sp,$sp,4
    	
    	bypass:
    	
    	addi $t0,$t0,1     # increment loop index
    	blt $t4, $s0,loop2  # 
    	
    	done:
    	
    	addi $t0, $zero, 1
    	addi $t1, $zero, 0
    	
    	while:
    		beq $t0, $s0, exit
    		addi $t0, $t0, 1 # increment i
    		
    		addi $t7, $t0, 1
    		mul $t3, $t7, 4
    		lw $t2, myArray($t3) # int[i]
    		
    		subu $sp,$sp,4
    		sw $ra, ($sp)
    		
    		#jal printPrime
    		beq $t2,1, printPrime # if int[i] == 1 print
    		
    		lw $ra, ($sp)
    		addu $sp,$sp,4
    		
    		#addi $t1, $t1, 4
    		
    		j while
  
		printPrime:
    			li $v0, 1
    			move $a0, $t0
    			syscall
    			
    			li $v0, 4
    			la $a0, space
    			syscall
    		
    			j while
    			#jr $ra
    	
    
    li $v0, 10
    syscall
    
    	
    
                     # print the message to standard output stream

exit: