# Programming Assignment #3 Pipeline Simulation (Due noon Dec. 6, 2021)

In this assignment, we will use a RISC-V pipeline simulator (Ripes) to observe the working of the pipeline.
Please setup the Ripes in your computers based on `Ripes_Setup_Mac.md` or `Ripes_Setup_Windows.md`.

## 1. Write an Assembly Program

1. Please follow above cmul.S to write your own assembly codes. 
   The code function should select from the following list according to the last digit of your student ID:
   For your program, please create and initialize all global variables for program inputs/outputs.
   Please use fixed number of sets or data to simplify your program, e.g., 4 inputs.
   (0) Radix sort (with 3-bit binary values) a set of integers and find the min value [reference link](https://www.geeksforgeeks.org/radix-sort/).
   (1) 2x2 kernel convolution with 3x3 matrix (all integers), and find the max value of the convolution output. Please see first example in [reference link](https://towardsdatascience.com/types-of-convolution-kernels-simplified-f040cb307c37).
   (2) 3-bit CRC computation  [reference link](https://en.wikipedia.org/wiki/Cyclic_redundancy_check#Computation)
   (3) Multiply two polynomials with integer coefficients, and find the sum of all coefficients of multiplication polynomial [reference link](https://www.geeksforgeeks.org/multiply-two-polynomials-2/).
   (4) Bisection method to find the nearest integer root of a polynominal of one variable [reference link](https://www.geeksforgeeks.org/program-for-bisection-method/).
   (5) Calculate the nearest centroid of a set of points on 2D integer grid [reference link](https://math.stackexchange.com/questions/1801867/finding-the-centre-of-an-abritary-set-of-points-in-two-dimensions).
   (6) Calculate hash value of a string with polynomial rolling hash function [reference link](https://cp-algorithms.com/string/string-hashing.html)
   (7) Count the number of neighbors of each node with an adjacency matrix of a graph and find the node with a maximum neighbors [reference link](https://www.geeksforgeeks.org/radix-sort/).
   (8) Use two arrays to store a binary tree [reference link](https://www.geeksforgeeks.org/binary-tree-array-implementation/).
       One array use 0 or 1 to indicate if a link is there for a child node. The other array store one integer for each node.
       Please calculate the max of two child nodes.
   (9) Find the closest pair from two sorted arrays [reference link](https://www.geeksforgeeks.org/given-two-sorted-arrays-number-x-find-pair-whose-sum-closest-x/)

2. Please find in your code the following dependency types:
   (RAW means read-after-write: we will use a register which is an Rd of earlier instructions).  

   (1) R-types RAW at following 1st instruction.  
   (2) R-types RAW at following 2nd instruction.   
   (3) Load RAW at following 1st instruction.   
   (4) Load RAW at following 2nd instruction.  
   (5) Branch instruction (control hazard).  

   Please comment your codes to indicate above conditions.
   Only one example of each type of RAW dependency should be noted.
   Also it's fine not to find a specific type of RAW in your program.

3. Please run your program with Ripes to make sure it's correct.

## 2. Simulate Pipeline

0. Please try to familiarize yourself with the [Ripes simulator](https://github.com/mortbopet/Ripes/wiki/Ripes-Introduction). 
1. Please run your code cycle by cycle with the 5-stage pipeline (default processor with forwarding and hazard detection enabled). 
   Please capture the cycles (with both pipeline details and stages) when the processor handles above 5 types of dependency or control hazards.
   Write a report to document the step by step process.
2. Redo above with a 5-stage pipeline without forwarding or hazard detection (select from the top-left corner).
   Note that you need to insert `nop` to make sure the program execute correctly (to handle hazards).
   You can write the report of this part in the same document.

   Note that we need to revise the first "la" instruction in the original cmul.S to run on this processor, as shown in the `cmul_nop.S`.
   It's because "la t0, aa" is translated by the assembler into two instructions (you can see it in the right side panel in Ripes):

   ```
   #original version
   la t0, aa
   nop
   nop
   lw a0, 0(t0)
   ```

   ```
   #translated version by assembler
   auipc t0, 0x1
   addi t0, t0, 140
   nop
   nop
   lw a0, 0(t0)
   ```

   Since this is a processor without forwarding and stall detection, the "addi"
   without "nop" cannot get the correct t0 from auipc (actually t0 is still 0
   in register file, so the result is t0=140 or 0x8C). Therefore, we get "0" for all the following loads.

   The solution is to directly use the two instructions above in the assembly,
   but we have to manually insert the correct value for the address of the data
   segment as shown in the following codes:

   ```
   auipc t0, 0x1
   nop
   nop
   addi t0, t0, 148
   nop
   nop
   lw a0, 0(t0)
   ```

   In the codes, we only insert 2 additional nops, because the register file 
   support same cycle write and read. And the addi imm is changed to 148 (from 140), because
   the 2 additional nops increase the text (code) segment by 8 bytes. This increase of code segment also 
   move the beginning of data segment 8 bytes further (hence 140+8=148).

   We can use the assembler to calculate this address for us by keeping the "la" instruction and inserting 2 nops:

   ```
   la t0, aa
   nop
   nop
   nop
   nop
   lw a0, 0(t0)
   ```
   After loading the translated binary into Ripes, we can check the addi imm value, which is the lower 12 bits
   of data segment.

## 3. Submit reports

Please submit your assembly codes and report files in pdf to EEClass.
