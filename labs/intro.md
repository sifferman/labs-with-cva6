
# Introduction to CVA6 Lab

This lab will help you become acquainted with the CVA6 core. First, you will need to read through and follow along with the [Getting Started Guide](../guides/getting-started.md). If you are having difficulties with the tool setup, please first complete the questons that do not require any setup.

## GitHub Questions

We are assuming that you have some familiarity with Git and GitHub already. If you do not, I recommend first watching this [Git and GitHub introductory video](https://www.youtube.com/watch?v=e-9qScNVs1o&t=251s).

Next, refer to this guide as needed: [Creating a permanent link to a code snippet](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-a-permanent-link-to-a-code-snippet).

1. What is a Git commit? What is the hash of the commit that first added [this file](https://github.com/sifferman/labs-with-cva6/blob/main/labs/intro.md) to this repository?

A git commit is an edit made to a file in git that contains changes made to a file(s) at a certain instance. Hash is a766fc11f700cb1ad442a24339613945cd15f9e5.
2. Using [`"./labs/intro/git-example.txt"`](https://github.com/sifferman/labs-with-cva6/blob/main/labs/intro/git-example.txt), provide a link (URL) to the line that describes who wrote that file.

https://github.com/sifferman/labs-with-cva6/blob/0b79133fa90623cf1936d022f0483c863f12db65/labs/intro/git-example.txt#L3
3. Using that same file, open its initial commit and create a permalink to the line that describes who wrote that file.

https://github.com/sifferman/labs-with-cva6/blob/a766fc11f700cb1ad442a24339613945cd15f9e5/labs/intro/git-example.txt#L2
4. Why should you always use permalinks when sending links to lines of code via GitHub?

This is because it makes reviewing code much faster and more streamlined instead of having to dig for a line.
5. What is a Git submodule, and what are they used for? What is the hash of the cva6 submodule that this repository uses?

A git submodule is a part of one repo that is a refernce to a specific commit of another repo.

## SystemVerilog Questions

1. Provide a link to the IEEE 1800-2017 SystemVerilog standard. (You will need the UCSB network to access <https://ieeexplore.ieee.org/Xplore/home.jsp>)
https://ieeexplore.ieee.org/document/8299595
2. In the keyword `always_comb`, what does "comb" refer to? What is its Verilog equivalent? Provide a GitHub permalink to an instance of `always_comb` in CVA6.
Comb refers to combinational logic, with its verilog equivalent being ***an always @ statement followed with the logic.*** 
https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/frontend.sv#L167
3. In the keyword `always_ff`, what does "ff" refer to? What is its Verilog equivalent? Provide a GitHub permalink to an instance of `always_ff` in CVA6.
The ff refers to a flip flop, and its verilog equivalent  being ***an always statements followed with a flip flop and associated logic***
https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/frontend.sv#L355
4. What is a SystemVerilog package, and how do you reference its contents in another file? Provide a GitHub link to `ariane_pkg.sv` and a permalink to an instance where `ariane_pkg` is imported and used in another file.
A SystemVerilog package is a package that is imported to add functionality and additional mechanisms to a a program. 
Package: https://github.com/openhwgroup/cva6/blob/7c92b68b922f05f2898a48f0a160f359ba24d805/core/include/ariane_pkg.sv
Useage in another file: https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/frontend.sv#L18
5. What is a struct, and how do you access struct members? Provide a GitHub link to a struct definition in CVA6 and a permalink to where a member of that struct is used.
A struct is a functionality that allows us to concatenate various variables and characteristics into a single object. 
https://github.com/openhwgroup/cva6/blob/7c92b68b922f05f2898a48f0a160f359ba24d805/core/include/ariane_pkg.sv#L364
https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/frontend.sv#L56
6. What are block names? Provide a GitHub permalink to an instance of a block name in CVA6.
Block names are blocks that are named by adding a name after keywords begin or fork. 
https://github.com/openhwgroup/cva6/blob/6deffb27d7f031341e33e84c422a19e39095aa6c/core/frontend/frontend.sv#L71

## RISC-V Questions

1. Provide a link to the latest RISC-V ISA Manual.
github.com/riscv/riscv-isa-manual
3. What are the 6 instruction formats of RISC-V? Give a one-to-three word description of each.

5. What is a compressed instruction and what are they used for?

## CVA6 Questions

1. Attach the block diagram of CVA6 provided in the [core's documentation](https://docs.openhwgroup.org/projects/cva6-user-manual/01_cva6_user/).

2. Skim the [CVA6 user manual](https://docs.openhwgroup.org/projects/cva6-user-manual/01_cva6_user/) and give a one sentence summary for each of the 6 pipeline stages.

3. Which stages are in the "frontend", and which are in the "backend"?

4. Expand the following acronyms: RISC-V, CVA6, IF, ID, EX, I\$, D\$, FIFO, TLB, ITLB, CSR, BHT, RAS, BTB, MMU, EPC, MTVEC, LSU, PTW, DTLB, ALU, FPU, OoO, WB, AXI, APU.
CVA6 - , OoO - Out of Order, APU - application processing unit, 
5. What is the difference between the `"./cva6/corev_apu"` and `"./cva6/core"` directories?
Core apu is where the applications and testing is done, where as the core is where the architecture actually is.
6. What is AXI and what is it primarily used for in CVA6?

## ELF Questions

1. What is an ELF file and where are they used? (Not specific to CVA6)
A file that describes the program memory and stores all the memory of the file.
2. What is the difference between segments and sections?
3. Compile [`"./programs/examples/asm.s"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/examples/asm.s), and (using your favorite hex viewer) give the offset into the ELF file at which the `add` instruction is located. Please also provide a screenshot.
4. Write a `.s` file that contains instructions covering all 6 of the instruction formats, a branch taken condition, and a compressed instruction. Compile it to an ELF file. (Provide both the `.s` file and the `.elf` file in your submission.)
5. Write a `.c` file that contains a `for` loop with iteration count of at least 5. Compile it to an ELF file. (Provide both the `.c` file and the `.elf` file in your submission.)

## Simulation Questions

Refer to the [Getting Started Guide](../guides/getting-started.md) if you need help setting up the required tools for simulation.

Also, when providing screenshots of waveforms, please include all signals you decide are relevant to demonstrate the event. Improper justification will result in a lower score.

1. Give the hierarchical path and GitHub permalink of the declaration of the PC in the instruction decode stage.
2. Give the hierarchical path and GitHub permalink of the declaration of the ALU output.
3. Give the hierarchical path and GitHub permalink of the declaration of the instruction in the execute stage.
4. Simulate [`"./programs/examples/asm.s"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/examples/asm.s), and give the time and a waveform screenshot of the `add` instruction occurring in the ALU. Provide justification.
5. Simulate the `.s` file you wrote, and provide the timestamp and a waveform screenshot at: a taken branch, a store to memory, a register file write, and a decode of a compressed instruction. Provide justification.
6. Simulate the `.c` file you wrote, and provide the timestamp and a waveform screenshot at the `for` loop beginning and end. Provide justification.
