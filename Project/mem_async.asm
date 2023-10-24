.text
L1:
add $t0,$zero,$zero
add $t6,$zero,$zero

lw $t1,64($t0)
lw $t2,68($t0)
lw $t3,72($t0)
sw $zero,76($t0) #the sum will be at this location(76)

loop:
lw $t4,0($t0)
lw $t5,76($t6)
add $t5,$t5,$t4
#
addi $t6,$t6,10
and $t3,$t3,$t4
or $t4,$t3,$t4
xor $t3,$t5,$t6
nor $t5,$t3,$t5
andi $t6,$t5,10
ori $t4,$t6,10
xori $t3,$t4,100
mult $t4,$t5
div $t4,$t3,$t5
sll $t3,$t4,10
srl $t4,$t5,10
sra $t5,$t3,10
sllv $t6,$t4,$t5
srlv $t7, $t6,$t5
lui $t8,100
slt $t5,$t4,$t6
slti $t6,$t5,-10
mfhi $t8
mflo $t7
#
sw $t5,76($t6)
sub $t1,$t1,$t2
add $t0,$t0,$t3
beq $t1,$zero,done
beq $t1,$t1, loop #actually jumb (because $t1 = $t1)
done:



#bne
#blez
#bgtz
