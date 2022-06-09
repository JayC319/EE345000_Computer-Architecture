# Programming Assignment #4 Cache Simulation (Due noon Jan. 7, 2022)

In this assignment, we will use a RISC-V pipeline simulator (Ripes) to observe the working of the cache.

## 1. Setup and Simulate Cache

1. Please load the program you created in PA3.
2. In the left panel, click "Memory" tab.
3. Design the cache with 4 indexes (2^2), 4 ways (2^2) and each block has 2 words (2^1). 
   So the total cache size is 4X4X2=32 words.
   Please leave other default options.
4. Please run simulation to show the following conditions with the captured cache status.
   For each case, please show the ld/st instruction and the parts of memory address as tag, index and offset, 
   cache status before and after the ld/st instruction, etc.

   (1) One case of cache insertion at an index with at least one way already occupied. Please also show how LRU bits change.
   (2) One case of replacement (a new block is requested at an index of which all four ways are occupied by other blocks).   
   (3) One case of write back (a block is replaced and has been written; D=1).   

   To stop and check the current CPU state, You can use the "Editor" panel in Ripes to find an 
   address and setup a breakpoint by clicking the left scroll bar.

   Note that if you cannot find above cases, please try to increase the number of variables or array size of your program.

5. Please zip and submit your codes and report files in pdf EEClass.
