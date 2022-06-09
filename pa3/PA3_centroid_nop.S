.data
.align 2
xx: .word  51,	71,	15,	90
yy: .word  40,	9,	96,	-90



str: .string " , "

.text
.global _start
_start:

    auipc t0, 0x1
    nop     
    nop
    # 2 nop for the correct t0 value to write back
    addi t0, t0, 212
    # 1 nop is needed only because the instruction depending on t0 is 2 instruction
    #   after the "addi t0, t0, 212 instruction"
    nop
    la t1, yy
    lw a0, 0(t0)
    lw a1, 4(t0)
    lw a2, 8(t0)
    lw a3, 12(t0)
    
    lw a4, 0(t1)
    lw a5, 4(t1)
    lw a6, 8(t1)
    lw a7, 12(t1)

    # enters the findCentroid function
    jal findCentroid
    mv t1, a1
   
    #print x value of centroid

    li a7, 1
    # 3 nop for ecall to work, don't know the reason
    nop
    nop
    nop
    ecall

    #print " , "
    la a0, str
    li a7, 4
    # 3 nop for ecall to work, don't know the reason
    nop
    nop
    nop
    ecall

    #print y value of centroid
    mv a0, t1
    li a7, 1
    # 3 nop for ecall to work, don't know the reason
    nop
    nop
    nop
    ecall

    j end


findCentroid:

    # store returned address
    addi sp, sp, -4
    sw ra, 0(sp)

    # addition of 4 values
    add t0, a0, a1
    add t1, a4, a5
    # nop added so that "add t0, t0, a2" can use the correct t0 value 
    nop  #newly added
    add t0, t0, a2
    add t1, t1, a6
    # nop added so that "add t0, t0, a3" can use the correct t0 value
    nop  #newly added
    add t0, t0, a3
    add t1, t1, a7
    # load the number of the arrays of x and y
    addi t2, x0, 4
    # nop added so that the div instruction can use the correct t2 value
    nop #newly added
    nop #newly added
    
    # divide the sum of x and y to the size
    # in this case is 4
    div a0, t0, t2
    div a1, t1, t2
    
    # load back the return address
    lw ra, 0(sp)
    addi sp, sp, 4
    
    
    jr x1

end:nop