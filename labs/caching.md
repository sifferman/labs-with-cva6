
# Caching

In this lab, you will add a victim cache to the [CVA6 I-Cache](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/cache_subsystem/cva6_icache.sv).

## Pre-Lab Questions

1. What is the purpose of a cache?
2. What is the purpose of a L1, L2, and L3 cache?
3. For the following questions, assume you have a CPU operating at 3.6 GHz.
    1. How many CPU clock cycles are needed to read from a DDR5-4800 CL40? (Assume a total latency of 16.67ns)
    2. How many CPU clock cycles are needed to read from an SSD over NVMe? (Assume a total latency of 10&mu;s)
    3. How many CPU clock cycles are needed to read from an SSD over SATA? (Assume a total latency of 70&mu;s)
    4. How many CPU clock cycles are needed to read from an HDD over SATA? (Assume a total latency of 10ms)
4. Why are caches designed using SRAM? What are the pros and cons of the 3 most-common volatile storage elements: flip-flops, SRAM, and DRAM?
5. Provided is a circuit diagram of an SRAM cell and SRAM array. (BL - Bit Line, WL - Word Line, Q - data) Use them to give a 1-sentence response for each of the following questions:
    [![SRAM Cell 6T](./caching/figures/SRAM_Cell_6T.svg)](https://en.wikipedia.org/wiki/Static_random-access_memory)
    [![SRAM Array](./caching/figures/SRAM_Array.png)](http://www.barth-dev.de/knowledge-corner/digital-design/memory-array-architectures/)
    1. How is a bit read from an SRAM cell?
    2. How is a bit written to an SRAM cell?
    3. How is a word read from an SRAM array?
    4. How is a word written to an SRAM array?
6. What is the purpose of a Victim Cache? When is it written to and read from?

## Part 1

In this part, you will finish an implementation of a Victim Cache.

The implementation should be a fully-associative cache with LRU replacement policy. It should have support for any positive integer cache size, meaning that the LRU algorithm will change a bit depending on the specified size. For a cache size of 1, there is no LRU logic necessary because only one way can be replaced. For a cache size of 2, there should be a single bit specifying which way was least recently accessed, and therefore which way should be replaced. For a cache size >2, there should be a doubly-linked-list (DLL) that orders each way from LRU to MRU; every read/write should bump the corresponding way to the MRU of the DLL, and every write should replace the LRU of the DLL.

Note that since it is a fully-associative cache, you should not infer a BRAM, but should instead infer an array of registers.

The module you need to finish is [`"ucsbece154b_victim_cache.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/part2/starter/ucsbece154b_victim_cache.sv), found in [`"labs/caching/part2/starter"`](https://github.com/sifferman/labs-with-cva6/tree/main/labs/caching/part2/starter). Your job will be to fix all the lines labeled `// TODO`. You can simulate your changes with ModelSim using `make sim TOOL=modelsim` (or Verilator 5 using `make sim TOOL=verilator` assuming that you have it set up). A [sample testbench](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/part2/starter/tb/victim_cache_tb.sv) is provided that you may edit as desired.

## Part 2

In this part, you will change the CVA6 filelist to add your victim cache to the I-Cache. Additionally, you will write a simple assembly program that simulates CVA6 with the victim-cache.

### Updates to I-Cache

CVA6's I-Cache is implemented here: [`"cva6/core/cache_subsystem/cva6_icache.sv"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/cache_subsystem/cva6_icache.sv). It is highly parameterizable, allowing you to change the number of entries, the number of ways, and more. A modified version of this implementation is provided to you here, [`"ucsbece154b_icache.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/part2/ucsbece154b_icache.sv), which calls the victim cache that you created in the previous part.

Try to read through the files and answer the questions below.

### Verilog/SystemVerilog Generate

The starter code for [`"ucsbece154b_victim_cache.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/part2/starter/ucsbece154b_victim_cache.sv) includes a [`generate` construct](https://www.chipverify.com/verilog/verilog-generate-block). A `generate` construct provides the ability for a module to be built based on parameters. These statements are used when an operation or module instance needs to be conditionally included or repeated.

Here are some examples inside CVA6 of using `generate` blocks:

* [`generate for` example](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/alu.sv#L42-L50)
* [`generate if` example](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/cva6.sv#L328-L338)

### Option `-f <file>`

(Nearly) all Verilog/SystemVerilog tools have the command-line option `-f <file>` which reads the specified file as additional command line arguments. ([Verilator `-f` documentation](https://veripool.org/guide/latest/exe_verilator.html#cmdoption-0)). This is extremely useful and common for providing a list of RTL files, because any files specified will be treated as source files to be compiled. CVA6's [Makefile](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/Makefile#L542) calls `-f` on [`"cva6/core/Flist.cva6"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/Flist.cva6).

Modify [`"cva6/core/Flist.cva6"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/Flist.cva6) by removing the file [`"cva6/cache_subsystem/cva6_icache.sv"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/cache_subsystem/cva6_icache.sv), and adding the files [`"ucsbece154b_icache.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/part2/ucsbece154b_icache.sv) and [`"ucsbece154b_victim_cache.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/part2/starter/ucsbece154b_victim_cache.sv). (Be sure that you get the paths correct; feel free to move files as needed.)

### Simulating the Victim Cache

Provided are list of hints to help you write a program that meets the specifications described in [Part 2](#part-2-questions) question 4:

* The simulation should finish in under a minute.
* You should not modify the cache size.
* The victim cache will only be written to when all the ways of a cache index are full.
* You should jump between multiple instructions with PCs that give the same cache index value.
* You can align instructions to a PC with a power of 2 by prefacing the instruction with the directive `.align <size-log-2>`. Use this to generate an instruction with a specific PC. Be sure to speed up the simulation by jumping past the `nop` instructions that `.align` inserted.
* You can view the instructions and PCs of an ELF file with the following command: `riscv64-unknown-elf-objdump -d <PATH TO PROGRAM>.elf`
* Refer to the [Trace Log](#cva6-trace-log) before looking at the waves to more-quickly see if your program is working.

### CVA6 Trace Log

CVA6 simulations create a log file: `"cva6/trace_hart_00.dasm"`. For every instruction that the simulation ran, it shows the cycle number, VPC, privilege mode, and instruction. It will be a very useful reference for this lab.

Notes:

* "Hart" means hardware thread, which is the same thing as a core.*
* Sometimes the core randomly enters Debug mode. (Observe `TOP.ariane_testharness.i_ariane.i_cva6.debug_mode`). As long as the core returns to normal execution, you can ignore this. If the simulation never exits, then your code has a bug.

Additional resource: [RISC-V Instruction Encoder/Decoder](https://luplab.gitlab.io/rvcodecjs/).

### Part 2 Questions

1. Using the original CVA6 icache, [`"cva6/cache_subsystem/cva6_icache.sv"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/cache_subsystem/cva6_icache.sv), answer the following questions:
    1. How is the table index calculated?
    2. How is the tag calculated?
    3. Provide a permalink to the logic that causes the core to stall, assuming a miss has occurred and the main memory request hasn't been fulfilled yet. (In `"frontend.sv"`.)
2. Using the modified icache, [`"ucsbece154b_icache.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/part2/ucsbece154b_icache.sv), answer the following questions:
    1. When is the victim cache written to?
    2. What occurs in the `VICTIM_HIT` state?
    3. What occurs in the `VICTIM_MISS` state?
3. Show the changes you made to [`"cva6/core/Flist.cva6"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/Flist.cva6).
4. Provide a program that demonstrates the following behaviors of the I$ and victim cache, and provide waveform screenshots of each event.
    1. An I$ miss.
    2. An I$ hit. What value+tag was read?
    3. A write to the victim cache. What value+tag was written?
    4. A victim cache hit. What value+tag was read?
