
# Virtual Memory

In addition to the lectures, please use the following resources to help you with this lab:

* [RISC-V Privileged Architecture Manual](https://github.com/riscv/riscv-isa-manual)
* ["RISC-V Bytes: Privilege Levels" by Daniel Mangum](https://danielmangum.com/posts/risc-v-bytes-privilege-levels/)

## Privilege

RISC-V has functionality for "privilege modes". Depending on the privilege mode a program is in, certain functionalities or memory addresses can be enabled or disabled. This is a summary of the privilege modes:

* Machine-mode: Highest privilege, all memory addresses are enabled. Used by bootloader.
* Supervisor-mode: All addresses except user addresses are enabled. Used by OS.
* User-mode: Lowest privilege, only user addresses can be accessed. Used by programs.

[![Privilege Levels](./vm/priv_levels.png)](https://danielmangum.com/posts/risc-v-bytes-privilege-levels/)

A core will always start in M-mode, which does not support virtual memory. To enable virtual memory, OS must lower the privilege to either S-mode or U-mode. This is demonstrated in [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/os.S) and [`"programs/vm/privilege.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/privilege.S).

## Provided OS Explanation

You have been provided a simple Bootloader and OS: [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/os.S). It is an example of how to set up and enable a page table, and lower the privilege to U-mode.

These are the steps it takes in more detail:

1. **Run bootloader in M-mode**
2. Set up the page table
3. Configure PMP
4. **Jump to the OS in S-mode**
5. Enable virtual memory using the page table
6. Add the user program to the page table
7. Load the user program to user memory
8. **Jump to the program in U-mode**
9. [`"rvfi_tracer.sv"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/corev_apu/tb/rvfi_tracer.sv#L74-L77) hits a breakpoint at `ecall` and exits the simulation

Note, out of simplicity's sake, there are a few important OS features that have not been fully implemented, such as:

* The code does not implement trap handlers for `ecall` instructions.
* The kernel and each user process should have their own page table.
* User processes are usually loaded to addresses starting at 0x0.

In this lab, you will be implementing basic trap handlers.

## Prelab

You will need the [RISC-V Privileged Architecture Manual](https://github.com/riscv/riscv-isa-manual) to answer some of these questions.

1. What is the purpose of virtual memory?
2. Define the following: MMU, PTW, TLB.
3. What is the benefit of a multi-layer page table?
4. For Sv39, give
    1. The number of bits in a VA
    2. The number of bits in a PA
    3. The number of layers a PT can be
    4. The size of a page in bytes
    5. The size of a PTE in bytes
5. Complete the following page table entry questions.
    1. Provide a diagram of a Sv39 PTE.
    2. List and define the 10 bottom bits of a Sv39 page table entry.
    3. In [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/os.S), each PTE's bottom 8 bits are set to either `0x1`, `0xef`, or `0xff`; explain the purposes of each of these three values in the context of [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/os.S).
6. Draw a diagram of the hierarchical page table created in [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/os.S) (unmodified).
    * Show/describe the contents of every valid PTE in each PT.
    * Denote pointers from a PTE to another layer with an arrow to the corresponding PT.
    * Show the contents of every valid physical frame in physical memory.
7. In [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/os.S) and [`"programs/vm/privilege.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/privilege.S), several control/status registers are written. For each of the registers, provide a screenshot of the bit diagram, and a definition of each of any fields that the provided programs use. (For example, [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/os.S) only uses the `SUM` from `sstatus`, so `SUM` is the only field you need to give a definition of for `sstatus`).
    1. `mstatus`
    2. `sstatus`
    3. `mepc`
    4. `sepc`
    5. `mtvec`
    6. `stvec`
    7. `satp`
    8. `medeleg`

## Lab

The current simulation runs just one user process, then stops the simulation once the `ecall` is run in the user program. However, we want to modify it to run 2 user processes sequentially, then stop the simulation if an `ecall` is run in M-mode. To achieve this, we need to modify the CVA6 testbench, and modify the provided OS code.

### CVA6 Testbench Modification

The CVA6 testbench is currently configured that any `ecall` instruction will stop the simulation. Edit this in [`"rvfi_tracer.sv"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/corev_apu/tb/rvfi_tracer.sv#L74) so that it only exits the simulation on an `ecall` in M-mode. (Hint: [`"rvfi_pkg.sv"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/corev_apu/tb/rvfi_pkg.sv), [`"riscv_pkg.sv"`](https://github.com/openhwgroup/cva6/blob/b44a696bbead23dafb068037eff00a90689d4faf/core/include/riscv_pkg.sv#L56))

### OS Modification

0. *Same initial setup...*
1. Create `m_trap` and `s_trap` trap handlers that are assigned to `mtvec` and `stvec`
2. Set `medeleg`
3. Create a counter that specifies which user program should be run (initialized to 1)
4. Load user program 1 to memory and configure the page table accordingly
5. Run user program 1 that has an `ecall` instruction
6. Return to the `s_trap` trap handler
7. Have `s_trap` increment the user program counter, then jump back to the OS
8. Load user program 2 to a different VA and PA than user program 1, and configure the page table accordingly
9. Run user program 2 that has an `ecall` instruction
10. Return to the `s_trap` trap handler
11. Have `s_trap` increment the user program counter, then jump back to the OS
12. On user program counter > 2, the OS runs `ecall`
13. Return to the `m_trap` trap handler
14. Have `m_trap` run `ecall` to exit the simulation

*Note: reference [`"programs/vm/privilege.S"`](https://github.com/sifferman/labs-with-cva6/blob/main/programs/vm/privilege.S) to help you set up your trap handlers.*

### CVA6 Trace Log

CVA6 simulations create a log file: `"cva6/trace_hart_00.dasm"`. For every instruction that the simulation ran, it shows the cycle number, VPC, privilege mode, and instruction. It will be a very useful reference for this lab.

Notes:

* *"Hart" means hardware thread, which is the same thing as a core.*
* *Simulation time should take no longer than 1 mintue.*
* *Sometimes the core randomly enters Debug mode. (Observe `TOP.ariane_testharness.i_ariane.i_cva6.debug_mode`). As long as the core returns to normal execution, you can ignore this. If the simulation never exits, then your code has a bug.*

Additional resource: [RISC-V Instruction Encoder/Decoder](https://luplab.gitlab.io/rvcodecjs/).

### Numerical Labels

Note that [`"programs/vm/os.S"`](https://github.com/sifferman/labs-with-cva6/blob/c5e49d3c7b3dd98ead3ae45898a29cbb437cf101/programs/vm/os.S#L95) demonstrates numerical labels with this line of code: `blt t0, t1, 1b;`.

Numeric labels are used for local references. References to local labels are suffixed with `f` for a forward reference or `b` for a backwards reference ([reference](https://michaeljclark.github.io/asm.html)). They are most useful when creating loops or conditionals that don't need to be given a name, and don't need to called by another file.

### Lab Questions

1. Show your modifications to `"rvfi_tracer.sv"`.
2. Show your modifications to `"os.S"`.
3. Draw a diagram of the hierarchical page table you created in your modified `"os.S"`.
    * Show/describe the contents of every valid PTE in each PT.
    * Denote pointers from a PTE to another layer with an arrow to the corresponding PT.
    * Show the contents of every valid physical frame in physical memory.
4. Provide your `"trace_hart_00.dasm"` file, and highlight the following behaviors:
    1. Enter `bootloader` in M-mode
    2. Enter `OS` in S-mode
    3. Enter user program 1 in U-mode; also provide its virtual and physical address
    4. Enter `s_trap` in S-mode
    5. Renter `OS` in S-mode
    6. Enter user program 2 in U-mode; also provide its virtual and physical address
    7. Renter `s_trap` in S-mode
    8. Renter `OS` in S-mode
    9. Enter `m_trap` in M-mode
    10. Exit
5. Provide a screenshot of a waveform demonstrating how the MMU translates the user program's virtual address to its physical address. *Note: The net hierarchical path to the MMU is `TOP.ariane_testharness.i_ariane.i_cva6.ex_stage_i.lsu_i.gen_mmu_sv39.i_cva6_mmu`.*
