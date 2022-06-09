# This example demonstrates an implementation of the multiplication of two
# complex numbers z = 1 + 3i, w = 4 + 5i.

.data
aa: .word 1, 3, 4, 5 # Real part of z, Imag. part of z, Real part of w, Imag part of w
str: .string " + i* "

.text
.global _start
_start:
    #la t0, aa
    auipc t0, 0x1
    nop
    nop
    addi t0, t0, 148
    nop
    nop
    lw a0, 0(t0)
    lw a1, 4(t0)
    lw a2, 8(t0)
    lw a3, 12(t0)

    # Do complex multiplication of numbers a0-a3
    jal complexMul
    mv t0, a1   # Move imaginary value to t0
    mv a0, a0   # Move real value to a1

    # Print real value (in a0) by setting ecall argument to 1
    li a7, 1
    ecall

    # Print delimiter string (pointer in a0) by setting ecall argument to 4
    la t1, aa
    addi a0, t1, 16
    li a7, 4
    ecall

    # Print imaginary value (in a0) by setting ecall argument to 1
    mv a0, t0   # Move imaginary value to a1
    li a7, 1
    ecall

    j end       # Jump to end of program

complexMul:
    # Place the 4 input arguments and return address on the stack
    addi sp, sp, -4
    sw ra, 0(sp) # return address

    # (a + ib)(c + id) = (ac − bd) + i(ad + bc)
    # Step 1: a*c
    mul t0, a0, a2 # ignore high MSB bits of results

    # step 2: b*d
    mul t1, a1, a3 

    # step 3: (ac − bd)
    sub t2, t0, t1 # t2 contains real part of multiplication

    # Step 4: a*d
    mul t0, a0, a3 

    # step 5: b*c
    mul t1, a1, a2 

    # step 6: (ad + bc)
    add a1, t0, t1  # a1 contains imag part of multiplication
    mv a0, t2      # a0 contains real part of multiplication

    lw   ra, 0(sp) # Reload return address from stack
    addi sp, sp, 4 # Restore stack pointer
    jr x1

end:nop
