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

  li a3, 0          # low
  addi a2, a2, -1   # high

  

  jal partition     # jump to function
  
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
  
  #load element index to swap a5 * 8 to t1 a4 * 8 to t2
  slli  t1,  a5,  3
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

#partition function

.global partition
partition:

  #store things in stack
  # return address and callee saved register
  addi  sp,  sp,  -32
  sd  s2,  24(sp)
  sd  s1,  16(sp)
  sd  s0,  8(sp)
  sd  ra,  0(sp)
  
  #initialize register as variable i and j saved in s1 and s2
  addi s1,  a3,  0  # store low to s1 equivalent to int i = low
  addi s2,  a3,  0  # store low to s2 equivalent to int j = low
  
  # equivalent to int pivot = arr[high] saved in s0
  slli t0, a2,  3     # store high * 8 to s3  # a2 = high
  add s0,  t0,  a0    # store address + high * 8 to s0
  ld  s0,  0(s0)      # store array[high] to s0
  

  partition_loop:
    
    beq s2,  a2,  partition_end  # if j is equal to high then go to parttion_end 
                                 # this is equivalent to j = high in for loop

    slli  t6,  s2,  3  # store j * 8 to t6
    add   t6,  t6,  a0 # store (address + j * 8) to t6 
    # now t6 has the address of array[j]
    ld    t6,  0(t6)   # store array[j] to t6   

    bge t6,  s0,  partition_skip     # skip if array[j] is greater or equal to pivot

    add a5,  s1, zero   # add i to arguement a5
    add a4,  s2, zero   # add j to arguement a4
    jal swap            # perform swap
  
    addi s1, s1, 1 # i += 1


    # this is enter when array[j] is greater or equal to pivot  
    partition_skip:
      
    addi s2, s2, 1  # j += 1
    beq x0, x0, partition_loop # loop partition
   
    
  partition_end:
    add a5, s1, zero  # add i to arguement a5  
    add a4, s2, zero  # add j to arguement a4
    jal swap

    addi a0,  s1, 0 # save return type in a0, equivalent of return i

  # load back callee saved register and return address
    ld  ra,  0(sp)
    ld  s0,  8(sp)
    ld  s1,  16(sp)
    ld  s2,  24(sp)
    addi sp,  sp,  32
    
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