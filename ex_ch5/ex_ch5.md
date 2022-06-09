# Exercise Chapter 5 (Due Dec. 27, 2021)

Please submit your answers with a pdf file to EEClass.
Note that no delay will be allowed for this exercise. 

## 1. Reading

Textbook: **CODV** Computer Organization and Design, RISC-V Ed. 

1. Chapter 5 of CODV: 5.3, 5.4, 5.7

## 2. Problems 

Credits are weightings of each problem in this exercise.
You can type your answers and submit the pdf, or hand write and scan it.
Please use Apps (e.g. Office Lens) to shoot a quality document.
If there is any issue of the submitted image quality, TA will reject the submission and no credit will be given.
   
1. [section 5.3] 
   For a direct-mapped cache design with a 12-bit memory address, 
   the following bit fields of the address are used to access the cache.

   |Tag            |Index          | Block offset  | Byte offset   |
   |:-------------:|:-------------:|:-------------:|:-------------:|
   |11- 9          | 8 - 5         |  4-2          |  1-0          |

   1. ( 5 points) What is the cache block size (in B)?
   2. ( 5 points) How many blocks does the cache have?
   3. ( 5 points) What is the total cache size? 
   4. (10 points) What is the actual SRAM memory size used to implement the cache? (Please consider tag bits, dirty bit, valid bit).
   5. (33 points) Please mark the following memory access references as "hit" or "miss" in the above cache.
      ```
      0xf48
      0xf58
      0xdc4
      0x44c
      0xdb4
      0xdac
      0xee4
      0xf30
      0xf40
      0x84c
      0x1cd
      ```
   6. (22 points) Please also mark the above memory access references with "replace" in the above cache.

   Now we would like to change the cache into a 4-way set associative design with the same total size.

   7. (10 points) What is the Index range for the new cache (address bit positions)?
   8. (10 points) What is the SRAM memory size used to implement the new cache?
      In this cache, we also need to add bits for pseudo-LRU replacement policy for each set.
   9. (33 points) Please mark the following memory access references as "hit" or "miss" in the new cache.
      The access sequence is the same as above problem 5.
      ```
      0xf48
      0xf58
      0xdc4
      0x44c
      0xdb4
      0xdac
      0xee4
      0xf30
      0xf40
      0x84c
      0x1cd
      ```

   10. (22 points) Please also mark the above memory access references with "replace" in the 4-way cache.
       Assume we use true LRU in the replacement policy.

2. (25 points) [section 5.4] 
   Consider the following processor with a few possible cache hierarchy choice (L2 or L3 designs):
   The base CPI without memory stalls is 1. The main memory access delay is 100 cycles.
   
   | Level                                   |access cycle and miss rate                |                  |
   |:---------------------------------------:|:----------------------------------------:|:----------------:|
   | L1                                      |L1 hit latency                            | 1                |
   | L1                                      |L1 miss rate                              | 3%               |
   | L2 (option 1: direct mapped)            |L2 access cycle                           | 12               |
   | L2 (option 1: direct mapped)            |L2 miss rate                              | 2.5%             |
   | L2 (option 2: 8-way set associative)    |L2 access cycle                           | 14               |
   | L2 (option 2: 8-way set associative)    |L2 miss rate                              | 2.0%             |
   | L3                                      |L3 access cycle                           | 40               |
   | L3                                      |L3 miss rate                              | 1.5%             |

   1. ( 5 points) Calculate the AMAT using only a 1-level cache.
   2. ( 5 points) Calculate the AMAT using a 2-level (L1, L2 direct-mapped) cache.
   3. ( 5 points) Calculate the AMAT using a 2-level (L1, L2 8-way set associative) cache.
   4. ( 5 points) Calculate the AMAT using a 3-level (L1, L2 DM, L3) cache.
   5. ( 5 points) Calculate the AMAT using a 3-level (L1, L2 8-way, L3) cache.

3. (15 points) [section 5.7] 
   Consider the following page table parameters:

   |Virtual address size     | Page size        | Page table entry size  |
   |:-----------------------:|:----------------:|:----------------------:|
   |32 bits                  | 32K bytes         | 4 bytes                |

   1. ( 5 points) Please calculate the maximum page table size for a system running 5 processes (in MB).
   2. (10 points) Assume we use the 2-level page table as specified by the following table.
      For a system running five applications that each utilize 100M Bytes of the virtual memory,
      please calculate the maximum page table size for a system running 5 processes (in MB).
      Please assume that P1 (first level) are all occupied and it also consume 4 bytes for each entry.

      |P1                       | P2               | Offset           |
      |:-----------------------:|:----------------:|:----------------:|
      | 8 bits                  | 9 bits           | 15 bits          |

