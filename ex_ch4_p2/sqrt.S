#
# This algorithm comes from Jack W. Crenshaw's 1998 article in Embedded:
# http://www.embedded.com/electronics-blogs/programmer-s-toolbox/4219659/Integer-Square-Roots

.data
aa: .word 65500 # input integer
str1: .string "Input: "
str2: .string "Sqrt: "
enter: .string "\n"
/*
astr: .string "a== "
rootstr: .string "root== "
remstr: .string " rem== "
*/


.text
.global _start
_start:
    # Print "Inputs:"
    la a0, str1
    li a7, 4
    ecall

    # Print input value
    lw a0, aa
    li a7, 1
    ecall
    # Print Enter
    mv t4, a0
    la a0, enter
    li a7, 4
    ecall
    mv a0, t4

    # Do sqare root computation of numbers aa
    jal sqrt32
    mv t0, a0   # save root to t0

    # Print "Sqrt: "
    la a0, str2
    li a7, 4
    ecall

    # Print sqrt of input
    mv a0, t0
    li a7, 1
    ecall
    # Print Enter
    la a0, enter
    li a7, 4
    ecall

    j end       # Jump to end of program

sqrt32:
    # Place return address on the stack
    addi sp, sp, -4
    sw ra, 0(sp) # return address

    # t0: index i
    # t1: rem
    # t2: root
    addi t0, x0, 16
    addi t1, x0, 0
    addi t2, x0, 0
loop:
    slli t2, t2, 1
    slli t3, t1, 2
    srli t4, a0, 30
    or  t1, t3, t4
    slli a0, a0, 2

    # Debug print root and rem values (in a0) 
    /*
    mv t4, a0 # save a0
    la a0, astr
    li a7, 4
    ecall
    mv a0, t4 # root
    li a7, 1
    ecall
    la a0, rootstr
    li a7, 4
    ecall
    mv a0, t2 # root
    li a7, 1
    ecall
    la a0, remstr
    li a7, 4
    ecall
    mv a0, t1 # rem
    li a7, 1
    ecall
    la a0, enter
    li a7, 4
    ecall
    mv a0, t4 # recover a0
    */

    bge t2, t1, L1
    or  t3, t2, 1
    sub t1, t1, t3
    addi t2, t2, 2

L1: 
    addi t0, t0, -1
    bgt t0, x0, loop
    srai a0, t2, 1

    lw   ra, 0(sp) # Reload return address from stack
    addi sp, sp, 4 # Restore stack pointer
    jr x1

end:nop
