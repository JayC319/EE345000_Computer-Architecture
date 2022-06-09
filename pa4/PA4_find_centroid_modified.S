.data
.align 3
xx: .word  -19,	88,	16,	-67 , 7,7,7,7, 5,5,5,5 ,4,4,4,4 , 3, 3, 3, 3
yy: .word  -28,	-40, 55,-43 , 8, 8,8,8, 6,6,6,6 ,9,9,9,9, 3, 3, 3, 3
xshift: .word 0,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,12


strl: .string " ( "
strr: .string " ) "
str: .string " , "
str1: .string " / "
str2: .string " xy ratio: "
strspace: .string " "
#stry: .string " y: "

.text
.global _start
_start:

    
    la t0, xx   # load forwarding at following 2nd instruction
    la t1, yy
    lw a0, 0(t0) # This is where new t0 value forwarded back
    lw a1, 4(t0)
    lw a2, 8(t0)
    lw a3, 12(t0)
    
    lw a4, 0(t1)
    lw a5, 4(t1)
    lw a6, 8(t1)
    lw a7, 12(t1)

    # enters the findCentroid function
    
    jal findCentroid
    
    mv t0, a0
    mv t1, a1
     #print " ( "
    la a0, strl
    li a7, 4
    ecall

    #print x value of centroid
    mv a0, t0
    li a7, 1
    ecall

    #print " , "
    la a0, str
    li a7, 4
    ecall

    #print y value of centroid
    mv a0, t1
    li a7, 1
    ecall

     #print " ) "
    la a0, strr
    li a7, 4
    ecall

    #print " / "
    la a0, str1
    li a7, 4
    ecall


    # trial 2
    ###################################################################

    la t0, xx   # load forwarding at following 2nd instruction
    la t1, yy
    lw a0, 16(t0) # This is where new t0 value forwarded back
    lw a1, 20(t0)
    lw a2, 24(t0)
    lw a3, 28(t0)
    
    lw a4, 16(t1)
    lw a5, 20(t1)
    lw a6, 24(t1)
    lw a7, 28(t1)

    # enters the findCentroid function

    jal findCentroid

     mv t0, a0
    mv t1, a1
     #print " ( "
    la a0, strl
    li a7, 4
    ecall

    #print x value of centroid
    mv a0, t0
    li a7, 1
    ecall

    #print " , "
    la a0, str
    li a7, 4
    ecall

    #print y value of centroid
    mv a0, t1
    li a7, 1
    ecall

     #print " ) "
    la a0, strr
    li a7, 4
    ecall

    #print " / "
    la a0, str1
    li a7, 4
    ecall
    
    #trial 3
    ###################################################################

    la t0, xx   # load forwarding at following 2nd instruction
    la t1, yy
    lw a0, 32(t0) # This is where new t0 value forwarded back
    lw a1, 36(t0)
    lw a2, 40(t0)
    lw a3, 44(t0)
    
    lw a4, 32(t1)
    lw a5, 36(t1)
    lw a6, 40(t1)
    lw a7, 44(t1)

    # enters the findCentroid function
    jal findCentroid
    mv t0, a0
    mv t1, a1
     #print " ( "
    la a0, strl
    li a7, 4
    ecall

    #print x value of centroid
    mv a0, t0
    li a7, 1
    ecall

    #print " , "
    la a0, str
    li a7, 4
    ecall

    #print y value of centroid
    mv a0, t1
    li a7, 1
    ecall

     #print " ) "
    la a0, strr
    li a7, 4
    ecall

    #print " / "
    la a0, str1
    li a7, 4
    ecall

    #trial 4
    ###################################################################

    la t0, xx   # load forwarding at following 2nd instruction
    la t1, yy
    lw a0, 48(t0) # This is where new t0 value forwarded back
    lw a1, 52(t0)
    lw a2, 56(t0)
    lw a3, 60(t0)
    
    lw a4, 48(t1)
    lw a5, 52(t1)
    lw a6, 56(t1)
    lw a7, 60(t1)

    # enters the findCentroid function
    jal findCentroid
    mv t0, a0
    mv t1, a1
     #print " ( "
    la a0, strl
    li a7, 4
    ecall

    #print x value of centroid
    mv a0, t0
    li a7, 1
    ecall

    #print " , "
    la a0, str
    li a7, 4
    ecall

    #print y value of centroid
    mv a0, t1
    li a7, 1
    ecall

     #print " ) "
    la a0, strr
    li a7, 4
    ecall

    #print " / "
    la a0, str1
    li a7, 4
    ecall

    # trial 5
    ###################################################################

    la t0, xx   # load forwarding at following 2nd instruction
    la t1, yy
    lw a0, 64(t0) # This is where new t0 value forwarded back
    lw a1, 68(t0)
    lw a2, 72(t0)
    lw a3, 76(t0)
    
    lw a4, 64(t1)
    lw a5, 68(t1)
    lw a6, 72(t1)
    lw a7, 76(t1)

    # enters the findCentroid function
    jal findCentroid
    mv t0, a0
    mv t1, a1
     #print " ( "
    la a0, strl
    li a7, 4
    ecall

    #print x value of centroid
    mv a0, t0
    li a7, 1
    ecall

    #print " , "
    la a0, str
    li a7, 4
    ecall

    #print y value of centroid
    mv a0, t1
    li a7, 1
    ecall

     #print " ) "
    la a0, strr
    li a7, 4
    ecall

    #print " / "
    la a0, str1
    li a7, 4
    ecall



    j end



findCentroid:

    # store returned address
    addi sp, sp, -4 # store forwarding at following 1st instruction 
    sw ra, 0(sp) # the new stack pointer address is forwarded back

    

    # addition of 4 values
    # R-type write and read at following 2nd instruction
    add t0, a0, a1
    add t1, a4, a5
    # R-type write and read at following 2nd instrucion
    add t0, t0, a2 # the new t0 value is forwarded back
    add t1, t1, a6 # the new t1 value is write back on time before this enters EX stage.
    add t0, t0, a3 # the new t0 value is forwarded back
    add t1, t1, a7

    # load the number of the arrays of x and y
    addi t2, x0, 4 # forwarding for the next 2 instruction. 
     
    # divide the sum of x and y to the size
    # in this case is 4

    # division write and read at following 2nd instruction
    div a0, t0, t2 # new value of t2 is forwarded
    div a1, t1, t2 # new value of t2 is forwarded


    # store the xy ratio back to an array
    # this part is just added to original code to see if write back is done.
    la t3, xshift
    lw t6, 0(t3)
    addi t4, a0, -5

    sw  t4, 0(t3)
    sw  t4, 4(t3)
    sw  t4, 8(t3)
    sw  t4, 12(t3)
    sw  t4, 16(t3)
    sw  t4, 20(t3)
    sw  t4, 24(t3)
    sw  t4, 28(t3)
    sw  t4, 32(t3)
    sw  t4, 36(t3)
    sw  t4, 40(t3)
    sw  t4, 44(t3)
    sw  t4, 48(t3)
    sw  t4, 52(t3)
    sw  t4, 56(t3)
    sw  t4, 60(t3)
    sw  t4, 64(t3)
    sw  t4, 68(t3)
    sw  t4, 72(t3)
    sw  t4, 76(t3)
    sw  t4, 80(t3)
    sw  t4, 84(t3)
    sw  t4, 88(t3)
    sw  t4, 92(t3)

    la t3, xshift
    addi t3, t3, 0
    lw t5, 96(t3)

    

    
    # load back the return address
    lw ra, 0(sp)
    addi sp, sp, 4
    jr x1

end:nop

