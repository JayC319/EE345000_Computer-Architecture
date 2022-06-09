.section .data
# There are two global variables:
#  1. array: Store the input numbers.
#  2. size: the number of the list
# You can modify the following two lines to test your program,
# but DO NOT change the line number
array: .dword 15, 20, 6, 35, 70, 7, 14, 36, 1, 21, 13, 3, 24, 5, 22, 2, 4, 10, 8, 12
size: .dword 20

# Variables for print function
# DO NOT modify these
dummy_msg: .ascii "   "
newline_msg: .ascii "\n"
ascii_msg: .ascii "Test"
magic_mem: .space 64

.section .text
.global main
main:

  # save return pointer
  addi sp, sp, -8
  sd ra, 0(sp)

  la a0, array      # assign array address to a0
  ld a2, size       # assign array size to a2

  li a3, 0          # first element index to swap
  li a4, 1          # second element index to swap

  

  jal swap          # jump to function

  jal print         # show results

  li a0, 0

  ld ra, 0(sp)
  addi sp, sp, 8

  ret               # return (jump to the address stored in register ra)

.global swap
swap:
  
  #save return address only
  # I originally save alot of s register
  # but swap can simply use temp register
  addi sp, sp, -8
  sd  ra, 0(sp)
  
  #load element index to swap a3 * 8 to t1 a4 * 8 to t2
  slli  t1,  a3,  3
  slli  t2,  a4,  3
 
  
  #load the address of array[index1] to t1 and array[index2] to t2
  add t1, a0, t1
  add t2, a0, t2
 
  # swap
  ld t3, 0(t1)  # load content in address of t1 to t3
  ld t4, 0(t2)  # load content in address of t2 to t4
  sd t4, 0(t1)  # store content of t4 back to address of t1
  sd t3, 0(t2)  # store content of t3 back to address of t2

  # store back return address
  ld ra, 0(sp)
  addi sp, sp, 8
  
ret   
  

####################################
# Helper function to print results #
#     DO NOT modify this!!!!!!     #
####################################
.global print
print:

  addi sp, sp, -72
  sd s7, 64(sp)
  sd s6, 56(sp)
  sd s5, 48(sp)
  sd s4, 40(sp)
  sd s3, 32(sp)
  sd s2, 24(sp)
  sd s1, 16(sp)
  sd s0, 8(sp)
  sd ra, 0(sp)

  la s0, array
  ld s1, size

  li s2, 0

print_loop:
  slli s3, s2, 3
  add s3, s0, s3
  ld s4, 0(s3)

  li s3, 10
  div s5, s4, s3
  rem s4, s4, s3

  beq s5, zero, less_than_10

  addi s5, s5, 48
  la s7, ascii_msg 
  sw s5, 0(s7)

  la s7, magic_mem
  li s6, 64
  sw s6, 0(s7)
  li s6, 1
  sw s6, 8(s7)
  la s6, ascii_msg
  sw s6, 16(s7)
  li s6, 1
  sw s6, 24(s7)
  la s6, tohost
  sw s7, 0(s6)

wait1:
  la s6, fromhost
  ld s7, 0(s6)
  beq s7, zero, wait1

  sw zero, 0(s6)

less_than_10:

  addi s4, s4, 48
  la s7, ascii_msg 
  sw s4, 0(s7)

  la s7, magic_mem
  li s6, 64
  sw s6, 0(s7)
  li s6, 1
  sw s6, 8(s7)
  la s6, ascii_msg
  sw s6, 16(s7)
  li s6, 1
  sw s6, 24(s7)
  la s6, tohost
  sw s7, 0(s6)

wait2:
  la s6, fromhost
  ld s7, 0(s6)
  beq s7, zero, wait2

  sw zero, 0(s6)

  la s7, magic_mem
  li s6, 64
  sw s6, 0(s7)
  li s6, 1
  sw s6, 8(s7)
  la s6, newline_msg
  sw s6, 16(s7)
  li s6, 1
  sw s6, 24(s7)
  la s6, tohost
  sw s7, 0(s6)

wait3:
  la s6, fromhost
  ld s7, 0(s6)
  beq s7, zero, wait3

  sw zero, 0(s6)

  addi s2, s2, 1
  bne s2, s1, print_loop

  ld ra, 0(sp)
  ld s0, 8(sp)
  ld s1, 16(sp)
  ld s2, 24(sp)
  ld s3, 32(sp)
  ld s4, 40(sp)
  ld s5, 48(sp)
  ld s6, 56(sp)
  ld s7, 64(sp)
  addi sp, sp, 72

  ret