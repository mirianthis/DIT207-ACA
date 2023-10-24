.data
L1:
add $t0,$zero,$zero
add $t6,$zero,$zero

lw $t1,64($t0)
lw $t2,68($t0)
lw $t3,72($t0)
sw $zero,76($t0) #the sum will be at this loctation(76)

loop:
lw $t4,0($t0)
lw $t5,76($t6)
add $t5,$t5,$t4
sw $t5,76($t6)
sub $t1,$t1,$t2
add $t0,$t0,$t3
beq $t1,$zero,done
beq $t1,$t1, loop #actually jumb (because $t1 = $t1)
done:
