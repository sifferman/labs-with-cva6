
# Introduction to CVA6 Lab

This lab will help you become acquainted with the CVA6 core. First, you will need to read through and follow along with the [Getting Started Guide](../guides/getting-started.md). If you are having difficulties with the tool setup, please first complete the questons that do not require any setup.

## GitHub Questions

We are assuming that you have some familiarity with Git and GitHub already. If you do not, I recommend first watching this [Git and GitHub introductory video](https://www.youtube.com/watch?v=e-9qScNVs1o&t=251s).

Next, refer to this guide as needed: [Creating a permanent link to a code snippet](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-a-permanent-link-to-a-code-snippet).

1. What is a Git commit? What is the hash of the commit that first added [this file](https://github.com/sifferman/labs-with-cva6/blob/main/labs/intro.md) to this repository?
2. Using [`"./labs/intro/git-example.txt"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/intro/git-example.txt), provide a link (URL) to the line that describes who wrote that file.
3. Using that same file, open its initial commit and create a permalink to the line that describes who wrote that file.
4. Why should you always use permalinks when sending links to lines of code via GitHub?
5. What is a Git submodule, and what are they used for? What is the hash of the cva6 submodule that this repository uses?

## SystemVerilog Questions

1. Provide a link to the IEEE 1800-2017 SystemVerilog standard. (You will need the UCSB network to access <https://ieeexplore.ieee.org/Xplore/home.jsp>)
2. In the keyword `always_comb`, what does "comb" refer to? What is its Verilog equivalent? Provide a GitHub permalink to an instance of `always_comb` in CVA6.
3. In the keyword `always_ff`, what does "ff" refer to? What is its Verilog equivalent? Provide a GitHub permalink to an instance of `always_ff` in CVA6.
4. What is a SystemVerilog package, and how do you reference its contents in another file? Provide a GitHub link to `ariane_pkg.sv` and a permalink to an instance where `ariane_pkg` is imported and used in another file.
5. What is a struct, and how do you access struct members? Provide a GitHub link to a struct definition in CVA6 and a permalink to where a member of that struct is used.
6. What are block names? Provide a GitHub permalink to an instance of a block name in CVA6.

## RISC-V Questions

1. Provide a link to the latest RISC-V ISA Manual.
2. What are the 6 instruction formats of RISC-V? Give a one-to-three word description of each.
3. What is a compressed instruction and what are they used for?

## CVA6 Questions

1. Attach the block diagram of CVA6 provided in the core's documentation.
2. Skim the [CVA6 user manual](https://docs.openhwgroup.org/projects/cva6-user-manual/01_cva6_user/) and give a one sentence summary for each of the 6 pipeline stages.
3. Which stages are in the "frontend", and which are in the "backend"?
4. Expand the following acronyms: IF, ID, EX, I\$, D\$, FIFO, TLB, ITLB, CSR, BHT, RAS, BTB, MMU, EPC, LSU, PTW, DTLB, ALU, FPU, AXI, CVA6, APU.
5. What is the difference between the `"./cva6/corev_apu"` and `"./cva6/core"` directories?
6. What is AXI and where is it primarily used?

## ELF Questions

1. What is an ELF file and where are they used? What is the difference between segments and sections?
2. Compile [`"./programs/examples/asm.s"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/examples/asm.s), and (using your favorite hex viewer) give the offset into the ELF file at which the `add` instruction is located. Please provide a screenshot.
3. Write a `.s` file that contains instructions covering all 6 of the instruction formats, a branch taken condition, and a compressed instruction. Compile it to an ELF file. (Provide both the `.s` file and the `.elf` file in your submission.)
4. Write a `.c` file that contains a `for` loop with iteration count of at least 5. Compile it to an ELF file. (Provide both the `.c` file and the `.elf` file in your submission.)

## Simulation Questions

1. Give the hierarchical path of the PC in the instruction decode stage.
2. Give the hierarchical path of the ALU output.
3. Give the hierarchical path of the instruction in the execute stage.
4. Simulate [`"./programs/examples/asm.s"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/examples/asm.s), and give the time and a waveform screenshot of the `add` instruction occurring in the ALU.
5. Simulate the `.s` file you wrote, and provide the timestamp and a waveform screenshot at: a taken branch, a store to memory, and a register file write, and a compressed instruction decoded.
6. Simulate the `.c` file you wrote, and provide the timestamp and a waveform screenshot at the `for` loop beginning and end.
