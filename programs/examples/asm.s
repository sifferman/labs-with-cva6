/*
 * File: asm.s
 * Description: Example of how to format a RISC-V assembly file to be read by CVA6.
 */

#include "program_stop.h"

        .text
# Text segment
        .globl _start;
_start: # entry point

        li      t0, 2022;
        li      t1, 2023;
        add     t2, t0, t1;

        li      a0, 0; # set exit value to 0
        j program_stop

        .data
# Data segment

arr: .asciz "Hello, world!"
