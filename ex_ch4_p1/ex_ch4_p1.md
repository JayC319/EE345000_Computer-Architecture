# Exercise Chapter 4 Part 1 (Due Dec. 1, 2021)

Please submit your answers with a pdf file to EEClass.
Note that no delay will be allowed for this exercise. We will review these question in class after the due day.

## 1. Reading

Textbook: **CODV** Computer Organization and Design, RISC-V Ed. 

1. Chapter 4 of CODV: 4.3 ~ 4.7

## 2. Problems 

Credits are weightings of each problem in this exercise.
You can type your answers and submit the pdf, or hand write and scan it.
Please use Apps (e.g. Office Lens) to shoot a quality document.
If there is any issue of the submitted image quality, TA will reject the submission and no credit will be given.

1. (20 points) [section 4.4] 
   For the single-cycle processor model (page 42 of `Chapter_04_1_single_cycle.pdf`), the CPU execute an instruction 0x00052A03
   fetched at 0x4000AC0d address. Please answer the following questions:  

   1. (5 points) What is the ALU function with the decoded instruction?  
   2. (5 points) What is the new PC after this instruction is executed?  
   3. (5 points) Please specify the control signals when executing this instruction.
      The list of control signals are RegWrite, ALUSrc, Branch, MemWrite, MemRead, MemtoReg.
   4. (5 points) What are the ALU inputs? Specify the value of a register by `Reg[x10]` if x10 is used.  
   
2. (40 points) [section 4.4] 
   The following table lists the latency of each block in the single-cycle processor model:

   |I-Mem/D-Mem   | Register Read  | Register Write| PC Read  | PC Write | Mux           | ALU           | Adder         | Single gate/shift| Sign extension| Decoder Contrl|
   |:-------------|:-------------::|:-------------:|:--------:|:--------:|:-------------:|:-------------:|:-------------:|:----------------:|:-------------:|:-------------:|
   |250ps         |  85ps          |  85ps         | 20ps     | 50ps     | 25ps          | 200ps         | 150ps         | 5ps              | 50ps          | 50ps          |

   When calculating the latency for the following instruction types, please consider ALL necessary stages including PC and write-back, etc.
   Assume the following: 
   (1) Add a latency to read PC for each instruction
   (2) PC is updated in parallel except for branch instruction.

   1. (5  points) What is the latency of an R-type instruction? (i.e., the clock period to execute R-type correctly).
   2. (10 points) What is the latency of `ld` instruction? 
   3. (10 points) What is the latency of `sd` instruction? 
   4. (5  points) What is the latency of `beq` instruction? 
   5. (5  points) What is the latency of an I-type instruction? 
   6. (5  points) What is the clock period of the processor considering all above instruction types? 
   7. (20 points) Please design a multi-cycle processor based on the latency of blocks in the above table.
      The goal is to design a processor with higher performance than single-cycle design.
      Note that a clock period cannot be lower than any block latency, since we cannot partition the block into multiple cycles.
      Also for each partitioned stage, we need to insert temporary registers (similar to pipeiline registers), and their
      latency is the same as PC (read=20ps and write=50ps).
      And all stages for any instruction should use the same clock period.

      And we have benchmark programs with the following mix of instruction types (in percentage):
      Please compare processor performance based on the instruction distribution, since multi-cylce designs will 
      optimize each instruction type's latency.

      |R-type I-type  |ld             | sd            | branch        |
      |:-------------:|:-------------:|:-------------:|:-------------:|
      |52%            |25%            | 11%           | 12%           |

   8. (10 points)[section 4.5] Please design a pipelined processor based on the latency of blocks in the above table.
      The design constraints are the same as above multi-cycle processor.
      Please also calculate the theoretical performance speedup by the pipelined processor.

   
3. (50 points) [section 4.4 and 4.5] For the following problems, you may use data path files in pptx to draw the new ones.
   1. (20 points) Please draw a new data path in the single-cycle processor to support a new maci instruction: maci rd, rs1, rs2, imm. 
      The function of the instruction can be represented as follows: Reg[rd]=Reg[rs2]+Reg[rs1]ximm   

   2. (10 points) With the block latency table in Problem 2, please calculate the latency for the new instruction. 

   3. (20 points) How do the pipeline design in Problem 2 change by including the new instruction?
      

4. (20 points) [section 4.5] 
   Assume we have designed a ALU for a 5-stage RV32I RISC-V core to support the following instructions (in additional to RV32I):
   All RV32I instructions use 1 clock cycle ALU. This is a multi-cycle pipelined processor that mul, div and sqrt need extra cycles to complete.

   |Instruction    | Clock cycle  | Format             |Function                           |
   |:-------------:|:------------:|:------------------:|:---------------------------------:|
   |mul            |  2           |  mul rd, rs1, rs2  | Multiplication rd=rs1xrs2         |
   |div            |  3           |  div rd, rs1, rs2  | Division rd=rs1/rs2               |

   Please draw the pipeline diagram for the following assembly program. Assume full forwarding support.
   What is the total execution cycle?

   ```
   addi x11, x12, 5 
   add x13, x11, x12
   mul x14, x11, 15
   div x15, x13, x12
   add x15, x14, x15
   ```


5. (20 points) [section 4.5] 
   Please add `nop` instruction to the following codes such that the results will be correct for a pipeline processor without forwarding support.
   Please draw the pipeline diagram for the 5-stage pipelined design.

   ```
   addi x11, x9, 5 
   add  x12, x10, x10
   addi x13, x11, 15
   add  x14, x13, x12
   ```

6. (10 points) [section 4.5] 
   Assume we have only one memory for both instruction and data. Please draw the pipeline diagram (5-stage processor and stages are IF, ID, EX, MEM, WB) for the following codes.
   Please specify the stall cycle by `**`. Note that for this processor with structural hazard, IF will have to stall for MEM if the instruction actually access the memory for data.

   ```
   ld  x29, 8(x10)
   sub x17, x15, x14
   ld  x30, 12(x10)
   beq x29, x30, L1
   add x18, x16, x17
   sub x15,x30,x17
   ```

7. (20 points) [section 4.7] 
   Please draw the pipeline diagram (5-stage processor) for the following codes.
   The processor has a full forwarding support.
   Please specify the stall cycle by `**`. Also mark the stage without useful work with `!`.

   ```
   ld x10, 0(x13)
   ld x11, 8(x13)
   add x12, x10, x11
   sub x14, x10, x11
   addi x13, x13, -16
   ```

8.  (20 points) [section 4.7] 
    For all the following code segments, please fix the data dependency with `nop` for the following 4 different processors:   
    (1) Add `nop` so that for processors without forwarding , the execution results are correct. 
    (2) Add `nop` so that for processors with forwarding from EX/MEM only, the execution results are correct.  
    (3) Add `nop` so that for processors with forwarding from MEM/WB only, the execution results are correct.   
    (4) Add `nop` so that for processors with full forwarding (both EX/MEM and MEM/WB), the execution results are correct.   

    Case with dependency from data memory to the following 1st instruction.

    ```
    ld x11, 0(x10)
    addi x12, x11, 4       
    addi x13, x11, 8
    ```

9. (20 points) [section 4.7] 
   For the following code segment, please list variables to check and generate the ForwardA and ForwardB selection conditions,
   and also stall conditions.
   For example, x10 is written by 1st add instruction and read by 2nd ld instruction. When "addi" is at MEM stage, we know that RegWrite==1,
   and EX/MEM.rd == ID/EX.RS1 == x10, such that ForwardA=2 (forwarding from EX/MEM.ALU_Result to 1st input of ALU).

   ```
   addi x10, x11, 4 
   ld   x12, 4(x10) 
   addi x13, x12, 8  
   ```
