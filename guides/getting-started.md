
# Getting Started

## About CVA6

From the [cva6 README](https://github.com/openhwgroup/cva6#readme):

> CVA6 is a 6-stage, single issue, in-order CPU which implements the 64-bit RISC-V instruction set. It fully implements I, M, A and C extensions as specified in Volume I: User-Level ISA V 2.3 as well as the draft privilege extension 1.10. It implements three privilege levels M, S, U to fully support a Unix-like operating system. Furthermore it is compliant to the draft external debug spec 0.13.

CVA6 is an open-source CPU core, widely used in academia and industry. It is primarily written by [Florian Zaruba](https://github.com/zarubaf), which makes its code style and organization very consistent.

## About "Labs with CVA6"

This repository includes several labs aimed at teaching advanced architecture techniques. To use this repository, you will need to:

1. Ensure you are on a Linux/WSL2 machine.
2. [Create an ssh key for GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux) and [add it to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?platform=linux).
3. Clone the project with `git clone git@github.com:sifferman/labs-with-cva6.git` into a directory of your choosing.
4. Initialize all submodules with `git submodule update --init --recursive` in the `"labs-with-cva6"` directory.

## Tool Setup

All necessary tools have been installed to linux.engr.ucsb.edu. Therefore we recommend using those machines to expedite the setup. If you want to run CVA6 simulations using your local Linux/WSL2 machine, you will need to install everything yourself.

### Local Tool Setup

1. Set `$RISCV` to wherever you want the tools to be installed to. i.e. run `RISCV=~/riscv-tools`
2. Run [`./cva6/ci/setup.sh`](https://github.com/openhwgroup/cva6/blob/master/ci/setup.sh). (If you get an error, you may need to rerun parts of the script manually).
3. Install the [OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build). You can do this by un-taring the latest release to a `"~/Utils/oss-cad-suite"` directory.
4. Add the following to your `"~/.bashrc"`, and replace the values of the 3 environment variables:

```bash
# ECE 154B local machine ~/.bashrc additions
# Author: Ethan Sifferman <ethan@sifferman.dev>
# Purpose: Configure riscv64-unknown-elf-gcc, fesvr, verilator-4.110, gtkwave
export RISCV_ROOT=<REPLACE THIS WITH YOUR RISCV ROOT>
export VERILATOR_ROOT=<REPLACE THIS WITH YOUR VERILATOR 4.110 ROOT>
export OSS_CAD_SUITE=<REPLACE THIS WITH YOUR OSS CAD SUITE ROOT>
export PATH=$RISCV_ROOT/bin:$VERILATOR_ROOT/bin:$PATH:$OSS_CAD_SUITE/bin
# end ECE 154B
```

### linux.engr.ucsb.edu Tool Setup

Add the following to your `"~/.bashrc"`:

```bash
# ECE 154B linux.engr ~/.bashrc additions
# Author: Ethan Sifferman <ethan@sifferman.dev>
# Purpose: Configure riscv64-unknown-elf-gcc, fesvr, verilator-4.110, gtkwave
export RISCV_ROOT=/ece/riscv
export VERILATOR_ROOT=/ece/verilator-4.110
export PATH=$RISCV_ROOT/bin:$VERILATOR_ROOT/bin:$PATH:/ece/oss-cad-suite/bin
# end ECE 154B
```

## Regular Setup

Before starting CVA6 simulations on a new terminal session, ensure proper environment configuration by running `source setup.sh`.

## Running Simulations

After setup is completed, you should be able to run CVA6 simulations. The primary way to run CVA6 simulations is to build and load an [ELF file](https://en.wikipedia.org/wiki/Executable_and_Linkable_Format). An ELF file is the standard file format used for Linux executables, so this means we can write any C/C++/RISC-V assembly program, and gcc/g++ will output a binary readable by CVA6. (You can see how the Verilog processes the ELF file [here](https://github.com/openhwgroup/cva6/blob/909d85a56cc5ace65765a63d7ed56b7ac2026f99/corev_apu/tb/ariane_tb.sv#L132-L152) and [here](https://github.com/openhwgroup/cva6/blob/e7dd85d4f9de4e3b236af92ced59a775b96ecee8/corev_apu/tb/dpi/elfloader.cc)).

### Building an ELF

You can see example programs in [`"./programs/examples"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/examples). You can compile the program to an ELF file using the [`"./programs/Makefile"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/Makefile). To use the Makefile, run `cd programs`, then run `make <PATH TO PROGRAM>.elf`, i.e. `make examples/asm.elf`. (Be sure that you've run `source setup.sh` first.)

### Running the Simulation

1. Ensure you've run `source setup.sh`
2. `cd cva6`
3. `make verilate DEBUG=1 TRACE_FAST=1`
4. `./work-ver/Variane_testharness -v dump.vcd <PATH TO ELF>` (You can change the vcd filename to whatever you want.)
5. To view the waves, run `gtkwave dump.vcd`. (This should probably be done in another terminal to not interfere with running more simulations.)
6. Navigate to **TOP.ariane_testharness.i_ariane.i_cva6** to see all the logic for the core.
7. Once you've selected all the waves necessary for your lab, be sure to save your workspace using "File->Write Save File", so next time you don't have to reopen all necessary waves again.
