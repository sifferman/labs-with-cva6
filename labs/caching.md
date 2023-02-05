
# Caching

In this lab, you will add a victim cache to the [CVA6 I-Cache](https://github.com/openhwgroup/cva6/blob/master/core/cache_subsystem/cva6_icache.sv).

## Pre-Lab Questions

### Verilog/SystemVerilog Questions

1. For the following questions, please use [DigitalJS Online](https://digitaljs.tilk.eu/), a Verilog synthesis visualizer, to support your answers.
    1. How is a Verilog/SystemVerilog `for` loop synthesized?
    2. How is a Verilog/SystemVerilog `if` statement synthesized?
2. CVA6 uses a common design practice of appending `_d` and `_q` to the end of net names. What does each mean? How should each net type be assigned? Why can this practice be more useful than using a single net?
3. When synthesizing Verilog/SystemVerilog into a netlist, the synthesis tool will often "infer" where you have created a block-RAM and try to optimize the design accordingly. This is extremely helpful if your target FPGA or ASIC already has built-in block-RAMs, because using the built-in block-RAMs will be much more power and area efficient than creating an equivalent design using flip-flops. For example, you can see that [DigitalJS Online](https://digitaljs.tilk.eu/) converts the Verilog array into a "RAM" logic cell.

   ```systemverilog
   module ram (
      input clk,
      input rst,
      // read port
      input [1:0] raddr_i,
      output [7:0] rdata_o,
      // write port
      input [1:0] waddr_i,
      input [7:0] wdata_i,
      input we_i
   );

   logic [7:0] RAM [0:3];

   assign rdata_o = RAM[raddr_i];

   always_ff @(posedge clk) begin
      if (we_i) RAM[waddr_i] <= wdata_i;
   end

   endmodule
   ```

   1. Add a `for` loop to this design so that when `rst` goes high, all the RAM cells' values are set to `'0` on the next clock cycle. Provide your modified code and a screenshot of what [DigitalJS Online](https://digitaljs.tilk.eu/) synthesized.
   2. Why is this reset strategy not scalable to larger RAM sizes? Theorize a better strategy to reset the RAM assuming that minimizing die area is much more important than execution time?

### Cache Questions

1. What is the purpose of a cache?
2. What is the purpose of a L1, L2, and L3 cache?
3. For the following questions, assume you have a CPU operating at 3.6 GHz.
    1. How many CPU clock cycles are needed to read from a DDR5-4800 CL40? (Assume a total latency of 16.67ns)
    2. How many CPU clock cycles are needed to read from an SSD over NVMe? (Assume a total latency of 10&mu;s)
    3. How many CPU clock cycles are needed to read from an SSD over SATA? (Assume a total latency of 70&mu;s)
    4. How many CPU clock cycles are needed to read from an HDD over SATA? (Assume a total latency of 10ms)
4. Caches are designed using SRAM. What are the pros and cons of using SRAM instead of DRAM or flip-flops for caches?
5. Provided is a circuit diagram of an SRAM cell and SRAM array. (BL - Bit line, WL - Word Line, Q - data) Use it to give a 1-sentence response for each of the following questions.
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

The module you need to finish is [`"ucsbece154b_victim_cache.sv"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/starter/ucsbece154b_victim_cache.sv), found in [`"labs/caching/starter"`](https://github.com/sifferman/labs-with-cva6/tree/main/labs/caching/starter). Your job will be to fix all the lines labeled `// TODO`. You can simulate your changes with ModelSim using `make sim TOOL=modelsim` (or Verilator 5 using `make sim TOOL=verilator` assuming that you have it set up). A [sample testbench](https://github.com/sifferman/labs-with-cva6/blob/main/labs/caching/starter/tb.sv) is provided that you may edit as desired.

## Part 2

*Coming soon...*
