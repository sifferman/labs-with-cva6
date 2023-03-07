/*
 * File: fpu_example.S
 * Description: Example of how to enable the FPU.
 */

        .text
# Text segment
        .globl _start;
_start: # entry point


        # enable FPU
        li      t0, (3 << 13);
        csrs    mstatus, t0;

        # load floats into f0 and f1
        la      t0, WORD_F0;
        flw     f0, 0(t0);
        la      t0, WORD_F1;
        flw     f1, 0(t0);

        # single precision RVF instructions
        fadd.s  f2, f0, f1;
        fmul.s  f3, f0, f1;
        fsqrt.s f4, f0;
        fmin.s  f5, f0, f1;

        # exit
        li      a0, 0;  # set exit value to 0
        li      a7, 93; # set syscall to `exit`
        ecall;


        .data
# Data segment
WORD_F0: .word 0x431a0000 # 154.0
WORD_F1: .word 0x41700000 #  15.0


        .section ".tohost","aw",@progbits
        .globl tohost
        .globl fromhost

        .align 6
tohost: .dword 0
        .align 6
fromhost: .dword 0
