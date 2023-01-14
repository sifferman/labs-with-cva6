/*
 * File: program_stop.s
 * Description: Run this function to stop a program.
 */

        .globl program_stop;
program_stop:
        # exit syscall
        li      a7, 93;         # set syscall to `exit`
        ecall;
