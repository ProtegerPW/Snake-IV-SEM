.data	
	array:	.byte 124, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 124
		.byte 124, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 124
		
	.eqv SIZE 22
	.eqv DATA_SIZE 1
	
	#################
	# Messsages     
	#################
	startMessage: .asciiz "\Welcome player\nYou are going to play snake\nMove snake using 'w' 'a' 's' 'd' buttons\nPress 'e' if you want to finish a game\n"
	newLine: .asciiz "\n"
	error: .asciiz "\nerror\n"
	errorWay: .asciiz "\n This direction is forbidden\n"
	gameOverMessage: .asciiz "\n d-.-b YOU LOST d-.-b \n" 
	
	################
	# Variables 
	################
	fruitX: .byte 0
	fruitY: .byte 0
	snakeHeadX: .byte 0
	snakeHeadY: .byte 0
	snakeTailX: .byte 0
	snakeTailY: .byte 0
	direction: .byte 119 #at start point - going up
	tailDirection: .byte 119
	
	dirChangeAddress: .word 0:100
	newDirChange: .word 0:100
	arrayPosition: .word 0
	locationInArray: .word 0

.text
	la $s0, array
	# initial snake position
	
	# generate X 
	li $v0, 42
	li $a1, 20
	syscall
	addi $a0, $a0, 1
	sb $a0, snakeHeadX
	
	# generate Y
	li $v0, 42
	li $a1, 14
	syscall
	addi $a0, $a0, 2
	sb $a0, snakeHeadY
	
	lb $a0, snakeHeadX
	lb $a1, snakeHeadY
	jal xyToAddress #get Address in array
	li $t1, 42
	sb $t1, ($v0)
	
	addi $a1, $a1, 1
	jal xyToAddress
	sb $t1, ($v0)
	
	addi $a1, $a1, 1
	jal xyToAddress
	sb $t1, ($v0)
	
	addi $a1, $a1, 1
	jal xyToAddress
	sb $t1, ($v0)
	
	addi $a1, $a1, 1
	jal xyToAddress
	sb $t1, ($v0)	
	
	sb $a0, snakeTailX
	sb $a1, snakeTailY
	#snake was created 
	
	li $s1, 0
	jal setFruit #set random fruit
	
	li $v0, 4
	la $a0, startMessage
	syscall 
	####################
	# Main game function
	####################
	game:
	jal printTable
	jal readCharacter
	jal drawHead #and update tail position
	
	j game
	
	############################################
	# Functions 
	###########################################
	printTable:
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $t0, 0 # x - index
	li $t1, 0 # y - index
	
	goThrY:
	li $t0, 0	
	
		goThrX:
		mul $t2, $t1, SIZE
		add $t2, $t2, $t0
		mul $t2, $t2, DATA_SIZE
		add $t2, $t2, $s0
		
		lb $t3, ($t2)
		move $a0, $t3
		li $v0, 11
		syscall
		
		addi $t0, $t0, 1
		blt $t0, SIZE, goThrX
		
		li $v0, 4
		la $a0, newLine
		syscall
	
		addi $t1, $t1, 1
		blt $t1, SIZE, goThrY
		
		jr $ra
	
	#############################################
	readCharacter: 	
	addiu $sp, $sp, -4
 	sw $ra, ($sp)
			
 	li $v0, 12
 	syscall
 	move $t1, $v0
 		
 	beq $t1, 119, isValidDirec
 	beq $t1, 115, isValidDirec
 	beq $t1, 97, isValidDirec
 	beq $t1, 100, isValidDirec
 	beq $t1, 101, goExit
 		
 	li $v0, 4
 	la $a0, error
 	syscall
 	
 	j readCharacter
 	
 	isValidDirec: #check is it possible to move based on input direction
 	lb $a0, snakeHeadX #calculate address of snake head to write it down later
 	lb $a1, snakeHeadY
 	jal xyToAddress
 	
 	add $a2, $v0, $zero # $a2 - address of snake's head
 	add $a1, $t1, $zero # $a1 - input direction
 	lb $a0, direction # $a0 - last direction
 	
 	beq $a0, $a1, goingStraight
 	beq $a0, 119, isGoingDown
 	beq $a0, 115, isGoingUp
 	beq $a0, 97,  isGoingRight
 	beq $a0, 100, isGoingLeft
 	
 	goingStraight:
 	j finishChecking
 	
 	isGoingDown:
 	beq $a1, 115, wrongWay
 	j acceptable
 	
 	isGoingUp:
 	beq $a1, 119, wrongWay
 	j acceptable
 	
 	isGoingRight:
 	beq $a1, 100, wrongWay
 	j acceptable
 	
 	isGoingLeft:
 	beq $a1, 97, wrongWay
 	j acceptable
 	
 	wrongWay:
 	li $v0, 4
 	la $a0, errorWay
 	syscall
 	j readCharacter
 	#-------------------------------------
 	acceptable:
 	beq $a1, 119, storeUpDir
 	beq $a1, 115, storeDownDir
 	beq $a1, 97, storeLeftDir
 	beq $a1, 100, storeRightDir
 	#-------------------------------------
 	storeUpDir:
 	lw $t4, arrayPosition
 	la $t2, dirChangeAddress
 	la $t3, newDirChange
 	add $t2, $t2, $t4
 	add $t3, $t3, $t4
 	
 	sw $a2, 0($t2)
 	li $t5, 119
 	sw $t5, 0($t3)
 	
 	addiu $t4, $t4, 4
 	bne $t4, 396, storeArrayPosU
 	li $t4, 0
 	
 	storeArrayPosU:
 	sw $t4, arrayPosition
 	j finishChecking
 	#---------------------------------------------
 	storeDownDir:
 	lw $t4, arrayPosition
 	la $t2, dirChangeAddress
 	la $t3, newDirChange
 	add $t2, $t2, $t4
 	add $t3, $t3, $t4
 	
 	sw $a2, 0($t2)
 	li $t5, 115
 	sw $t5, 0($t3)
 	
 	addiu $t4, $t4, 4
 	bne $t4, 396, storeArrayPosD
 	li $t4, 0
 	
 	storeArrayPosD:
 	sw $t4, arrayPosition
 	j finishChecking
 	#-------------------------------
 	storeLeftDir:
 	lw $t4, arrayPosition
 	la $t2, dirChangeAddress
 	la $t3, newDirChange
 	add $t2, $t2, $t4
 	add $t3, $t3, $t4
 	
 	sw $a2, 0($t2)
 	li $t5, 97
 	sw $t5, 0($t3)
 	
 	addiu $t4, $t4, 4
 	bne $t4, 396, storeArrayPosL
 	li $t4, 0
 	
 	storeArrayPosL:
 	sw $t4, arrayPosition
 	j finishChecking
 	#----------------------------------
 	storeRightDir:
 	lw $t4, arrayPosition
 	la $t2, dirChangeAddress
 	la $t3, newDirChange
 	add $t2, $t2, $t4
 	add $t3, $t3, $t4
 	
 	sw $a2, 0($t2)
 	li $t5, 100
 	sw $t5, 0($t3)
 	
 	addiu $t4, $t4, 4
 	bne $t4, 396, storeArrayPosR
 	li $t4, 0
 	
 	storeArrayPosR:
 	sw $t4, arrayPosition
 	j finishChecking
 	
 	goExit:	
	# End of program
	li $v0, 10
	syscall
	
	finishChecking:
	sb $a1, direction
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	jr $ra
	
 	#displayCharacter: 		
 	#move $a0, $t1
 	#li $v0, 11
 	#syscall
 	
 	##########################################
 	drawHead:
 	addiu $sp, $sp, -4
 	sw $ra, ($sp)
 	
 	lb $t7, direction
 	beq $t7, 119, DrawUp
 	beq $t7, 115, DrawDown
 	beq $t7, 97, DrawLeft
 	beq $t7, 100, DrawRight
 	#----------------------------------
 	DrawUp:
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	lb $a2, direction
 	jal checkCollision
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	add $a1, $a1, -1
 	jal xyToAddress
 	li $t1, 42
 	sb $t1, ($v0)
 	sb $a1, snakeHeadY
 	j timeForTail
 	#--------------------------------
 	DrawDown:
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	lb $a2, direction
 	jal checkCollision
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	addiu $a1, $a1, 1
 	jal xyToAddress
 	li $t1, 42
 	sb $t1, ($v0)
 	sb $a1, snakeHeadY
 	j timeForTail
 	#-------------------------------
 	DrawLeft:
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	lb $a2, direction
 	jal checkCollision
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	add $a0, $a0, -1
 	jal xyToAddress
 	li $t1, 42
 	sb $t1, ($v0)
 	sb $a0, snakeHeadX
 	j timeForTail
 	#-------------------------------
 	DrawRight:
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	lb $a2, direction
 	jal checkCollision
 	lb $a0, snakeHeadX
 	lb $a1, snakeHeadY
 	addiu $a0, $a0, 1
 	jal xyToAddress
 	li $t1, 42
 	sb $t1, ($v0)
 	sb $a0, snakeHeadX
 	j timeForTail
 	
 	
 	finishTail:
 	lw $ra, ($sp)
 	addiu $sp, $sp, 4
 	jr $ra
 	
 	##########################################
 	timeForTail:
 	lb $t0, snakeHeadX # check if snake ate fruit
 	lb $t1, fruitX
 	bne $t0, $t1, checkTailMovDir
 	lb $t0, snakeHeadY
 	lb $t1, fruitY
 	bne $t0, $t1, checkTailMovDir
 	li $s1, 0
 	jal setFruit
 	j finishTail
 	
 	checkTailMovDir:
 	lb $t0, tailDirection
 	beq $t0, 119, tailUp
 	beq $t0, 115, tailDown
 	beq $t0, 97, tailLeft
 	beq $t0, 100, tailRight
 	
 	#-------------------------------------------
 	tailUp:
 	lw $t5, locationInArray
 	la $t6, dirChangeAddress
 	add $t6, $t5, $t6
 	lw $t7, ($t6)
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	add $a1, $a1, -1
 	sb $a1, snakeTailY
 	jal xyToAddress
 	bne $t7, $v0, drawTailUp
 	
 	la $t4, newDirChange #change snake's tail direction
 	add $t4, $t4, $t5
 	lw $t3, ($t4)
 	sb $t3, tailDirection
 	addiu $t5, $t5, 4
 	bne $t5, 396, storeLocationUp
 	li $t5, 0
 	storeLocationUp:
 	sw $t5, locationInArray
 	
 	drawTailUp:
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	addiu $a1, $a1, 1
 	jal xyToAddress
 	li $t2, 32
 	sb $t2, ($v0)
 	j finishTail
 	
 	#------------------------------
 	tailDown:
 	lw $t5, locationInArray
 	la $t6, dirChangeAddress
 	add $t6, $t5, $t6
 	lw $t7, ($t6)
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	addiu $a1, $a1, 1
 	sb $a1, snakeTailY
 	jal xyToAddress
 	bne $t7, $v0, drawTailDown
 	
 	la $t4, newDirChange
 	add $t4, $t4, $t5
 	lw $t3, 0($t4)
 	sb $t3, tailDirection
 	addiu $t5, $t5, 4	
 	bne $t5, 396, storeLocationDown
 	li $t5, 0
 	storeLocationDown:
 	sw $t5, locationInArray
 	
 	drawTailDown:
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	add $a1, $a1, -1
 	jal xyToAddress
 	li $t2, 32
 	sb $t2, ($v0)
 	j finishTail
 	
 	#----------------------------------
 	tailLeft:
 	lw $t5, locationInArray
 	la $t6, dirChangeAddress
 	add $t6, $t5, $t6
 	lw $t7, ($t6)
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	add $a0, $a0, -1
 	sb $a0, snakeTailX
 	jal xyToAddress
 	bne $t7, $v0, drawTailLeft
 	
 	la $t4, newDirChange
 	add $t4, $t4, $t5
 	lw $t3, 0($t4)
 	sb $t3, tailDirection
 	addiu $t5, $t5, 4	
 	bne $t5, 396, storeLocationLeft
 	li $t5, 0
 	storeLocationLeft:
 	sw $t5, locationInArray
 	
 	drawTailLeft:
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	addiu $a0, $a0, 1
 	jal xyToAddress
 	li $t2, 32
 	sb $t2, ($v0)
 	j finishTail
 	
 	#-------------------------------------------------
 	tailRight:
 	lw $t5, locationInArray
 	la $t6, dirChangeAddress
 	add $t6, $t5, $t6
 	lw $t7, ($t6)
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	addiu $a0, $a0, 1
 	sb $a0, snakeTailX
 	jal xyToAddress
 	bne $t7, $v0, drawTailRight
 	
 	la $t4, newDirChange
 	add $t4, $t4, $t5
 	lw $t3, 0($t4)
 	sb $t3, tailDirection
 	addiu $t5, $t5, 4	
 	bne $t5, 396, storeLocationRight
 	li $t5, 0
 	storeLocationRight:
 	sw $t5, locationInArray
 	
 	drawTailRight:
 	lb $a0, snakeTailX
 	lb $a1, snakeTailY
 	addiu $a0, $a0, -1
 	jal xyToAddress
 	li $t2, 32
 	sb $t2, ($v0)
 	j finishTail
 		
 	##########################################
 	checkCollision:
 	addiu $sp, $sp, -4
 	sw $ra, ($sp)
 	
 	beq $a2, 119, checkUp
 	beq $a2, 115, checkDown
 	beq $a2, 97, checkLeft
 	beq $a2, 100, checkRight
 	#---------------------------------------------
 	checkUp:
 	add $a1, $a1, -1
 	jal xyToAddress
 	lb $t1, ($v0)
 	li $t2, 45 # check ceiling 
 	li $t3, 42 # check if there is snake
 	li $t4, 124 #check if there is wall
 	beq $t1, $t2, gameOver # hit ceiling - LOST
 	beq $t1, $t3, gameOver # hit yourself - LOST
 	beq $t1, $t4, gameOver # hit wall - LOST
 	j finishCollision
 	#--------------------------------------------
 	checkDown:
 	addiu $a1, $a1, 1
 	jal xyToAddress
 	lb $t1, ($v0)
 	li $t2, 45 # check ceiling
 	li $t3, 42 # check if there is snake 
 	li $t4, 124 #check if there is wall
 	beq $t1, $t2, gameOver # hit ceiling - LOST
 	beq $t1, $t3, gameOver # hit yourself - LOST
 	beq $t1, $t4, gameOver # hit wall - LOST
 	j finishCollision
 	#--------------------------------------------
 	checkLeft:
 	add $a0, $a0, -1
 	jal xyToAddress
 	lb $t1, ($v0)
 	li $t2, 45 # check ceiling
 	li $t3, 42 # check if there is snake 
 	li $t4, 124 #check if there is wall
 	beq $t1, $t2, gameOver # hit ceiling - LOST
 	beq $t1, $t3, gameOver # hit yourself - LOST
 	beq $t1, $t4, gameOver # hit wall - LOST
 	j finishCollision
 	#-------------------------------------------
 	checkRight:
 	addiu $a0, $a0, 1
 	jal xyToAddress
 	lb $t1, ($v0)
 	li $t2, 45 # check ceiling
 	li $t3, 42 # check if there is snake 
 	li $t4, 124 #check if there is wall
 	beq $t1, $t2, gameOver # hit ceiling - LOST
 	beq $t1, $t3, gameOver # hit yourself - LOST
 	beq $t1, $t4, gameOver # hit wall - LOST
 	j finishCollision
 	
 	finishCollision:
 	lw $ra, ($sp)
 	addiu $sp, $sp, 4
 	jr $ra
 	
 	##########################################
	setFruit:
	bnez $s1, finishFruit # check fruit's flag (description below)
	addiu $sp, $sp, -4
	sw $ra, ($sp)
	li $s1, 1 # set flag: 1 - fruit exist / 0 - was eaten
	
	setFruitXY:
	#generate X coordinate
	li $v0, 42
	li $a1, 20
	syscall
	addi $a0, $a0, 1
	sb $a0, fruitX
	move $t0, $a0
	
	#generate Y coordinate
	li $v0, 42
	li $a1, 20
	syscall
	addi $a0, $a0, 1
	sb $a0, fruitY
	move $t1, $a0
	
	addi $a0, $t0, 0
	addi $a1, $t1, 0
	jal xyToAddress
	#calculate address of fruitCell in array
	#mul $t2, $t1, SIZE
	#add $t2, $t2, $t0
	#mul $t2, $t2, DATA_SIZE
	#add $t2, $t2, $s0
	
	#check if there is a snake
	lb $t3,($v0)
	beq $t3, 42, setFruitXY
	
	#replace cell with fruit
	li $t1, 36
	sb $t1,($v0)
	
	lw $ra, ($sp)
	addiu $sp, $sp, 4
	finishFruit:
	jr $ra
	
	###########################
	# $a0 - X coordinate
	# $a1 - Y coordinate
	##########################
	xyToAddress:
	mul $v0, $a1, SIZE
	add $v0, $v0, $a0
	mul $v0, $v0, DATA_SIZE
	add $v0, $v0, $s0
	jr $ra
	
	gameOver:
	li $v0, 4
	la $a0, gameOverMessage
	syscall
	j goExit
