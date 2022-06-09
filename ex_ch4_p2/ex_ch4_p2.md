# Exercise Chapter 4 Part 2 (Due noon Dec. 17, 2021)

Please submit your answers with a pdf file to EEClass.
Note that no delay will be allowed for this exercise. We will review these question in class after the due day.

## 1. Reading

Textbook: **CODV** Computer Organization and Design, RISC-V Ed. 

1. Chapter 4 of CODV: 4.8 ~ 4.10

## 2. Problems 

Credits are weightings of each problem in this exercise.
You can type your answers and submit the pdf, or hand write and scan it.
Please use Apps (e.g. Office Lens) to shoot a quality document.
If there is any issue of the submitted image quality, TA will reject the submission and no credit will be given.
   
For the following codes, we will examine the branch prediction and two-issue static scheduling:  
The source codes of C and RISC-V assembly (and object dump including addresses, produced by `riscv64-unknown-elf-objdump -D sqrt.elf`) 
are also provided in this package.
 
      ```c
      #include <stdio.h>
      #include <stdint.h>
 
      uint16_t sqrt32(uint32_t a);
 
      int main(void) {
           	uint32_t small = 65500;
           	uint32_t sqrt_small = sqrt32(small);
           	uint32_t check_small = sqrt_small * sqrt_small;
 
           	printf("sqrt(%u) == %u\n", small, sqrt_small);
           	printf("%u^2 == %u\n", sqrt_small, check_small);
 
           	return 0;
      }
 
      uint16_t sqrt32(uint32_t a) {
           uint32_t rem = 0, root = 0;
           int i;
           for (i = 32 / 2; i > 0; i--) {
                   root <<= 1;
                   rem = (rem << 2) | (a >> (32 - 2));
                   a <<= 2;
                   //printf("\t a==%u; root==%u; rem==%u\n", a, root, rem);
                   if (root < rem) {
                           rem -= root | 1;
                           root += 2;
                   }
           }
           return root >> 1;
      }
      ```
      ```asm
      .data
      aa: .word 65500 # input integer
      str1: .string "Input: "
      str2: .string "Sqrt: "
      enter: .string "\n"
 
      .text
      .global _start
      _start:
         #Get input value
         lw a0, aa
         
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
      ```

1. Branch Prediction [section 4.8] 
   1. (20 points) Branch Prediction Trace  
      Please trace the assembly code of sqrt32 function and produce the branch execution traces.
      We would like to identify the Taken/Non-taken condition for each branch instruction.
      For example, we may have the following output for each branch instruction address.:
      ```
      0x100dc T
      0x100f0 NT
      ```
      It means a branch instruction at 0x100dc is a Taken (jump to a lable).
      And the branch instruction at 0x100f is a Non-taken (continue with PC+4).
      The address of a branch instruction can be found in the objdump file.
      For this part, you may program the codes to extract the trace or simply manually trace the codes.
      
   2. (20 points) 1-bit Branch Prediction 
      Please use 1-bit predictor with the trace from problem 1.1 to show the rate of prediction accuracy 
      (# correct prediction/# total branch instructions).
      The 1-bit predictor will transit between T and NT based on only the local address.
      Initially, all predictors are in NT state.
      
   3. (20 points) 2-bit Branch Prediction 
      Please use 2-bit predictor with the trace from problem 1.1 to show the rate of prediction accuracy 
      (# correct prediction/# total branch instructions).
      The 2-bit predictor will transit between (Strongly Taken, Weakly Taken, Weakly Non-Taken and Strongly Non-Taken) 
      based on only the local address.
      Initially, all predictors are in Weakly Non-Taken state.

   4. (10 points) Hash function  
      For problem 1.2 and 1.3, we assume we can access the states of each address directly. 
      However, we need to convert the address of a branch instruction with a hash function 
      and use the hash value as an index to the states. 
      Please design a 2-bit output hash function for branch addresses in our example sqrt assembly code.
      Apparently, it's not a good choice to use the 2 LSB bits, since it's always 00.

   5. (30 points) Global history and branch prediction 
      We would like to consider global branch history (results from previous branch instructions) in
      the predictor besides local address states (in 2-bit predictor).
      Please use 2 bits of global branch history and also 2-bit address hash values to index a 2-bit predictor.
      Please show how this predictor works in our example and compute the accuracy rate.
      Note that with 2-bit global history state and 2-bit local address hash, we will have a total of
      16 2-bit state table. The table will be mostly empty, so you don't need to show the complete table.
      Assume H=global history bits, L=branch instruction adddress hashed bits, P(H, L) is the prediction table with 2-bit states.
      Please show in your steps how P(H, L) predicts the branch and how P(H, L) is updated with the actual branch results (T, NT).

2. Two-issue Static Scheduling [section 4.10] 
   We would like to run the codes of sqrt32 function on a two-issue in-order processor:
 
   The two-issue, statically scheduled processor has the following properties:
 
   (1) Both instruction pipeline can execute all combination of two instructions.
       If there is any dependency between two instructions, please add proper stall cycles to the dependent instruction.  
       If a stall happens, all following instructions will also delay for the stall.
   (2) The processor has all possible forwarding paths between stages and pipelines.    
   (3) The processor uses a 1-bit local address branch predictor designed in previous problem.  
       If the prediction is wrong, we need to flush all following instructions after the EX stage of branch instruction is confirmed,
       and new PC will fetch from the correct address.
       Note that in this problem we assume compiler has a capability to predict just like dynamic execution.
   (4) Assume we fetch two instructions at the same time, but determine if they can be in the same packet at ID stage (by the controller).
   (5) The pipeline has 5 stages (IF, ID, EX, MEM, WB). At the ID stage,  we determine the data dependency and 
       stall to wait for the data from EX/MEM or MEM/WB.
 
   1. (30 points) Please draw a pipeline diagram showing how RISC-V codes above executes on the two-issue processor.
      Illustrate only one iteration of the loop. You may use the attached excel file `problem_ch4_p2_2.xlsx` as the initial template.
      Use '*' to show stalls and no issue.
 
   2. (30 points) Please rearrange the codes to minimize the cycle count for one iteration.
      Please draw a pipeline diagram showing how the new RISC-V codes above executes on the two-issue processor.
      Note that we can move instructions to remove data dependency in a packet.
 
   3. (40 points) Please unroll the loop for two iterations and rearrange the codes to minimize the cycle counts.
      Please draw a pipeline diagram showing how the new RISC-V codes above executes on the two-issue processor.
      Note again that we can move instructions to remove data dependency in a packet.
      Also we can merge addi for loop induction index.
      And after unrolling, we don't need the loop branch instructions.
      Finally, the branch prediction for the second iteration will be different with the 1-bit predictor.
