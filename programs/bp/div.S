/*
 * File: div.S
 * Description: Divisor check to benchmark the branch predictor.
 */

        .text
# Text segment
        .globl _start;
_start: # entry point
        li      t0, 20;                 # big_loop init
big_loop:
        addi    t0, t0, -1;             # big_loop counter
        beqz    t0, big_loop_end;       # big_loop exit condition


# div_loop:
# t0: reserved for big_loop
# a0: divisor, goes from 10-1
# t1: dividend, goes from 20-10
# a1: count how many times dividend/divisor evenly
        li a0, 11
div_loop:
        addi    a0, a0, -1;             # big_loop counter
        beqz    a0, div_loop_end;       # div_loop exit condition


        li a1, 0; # counter



check_20:
        li t1, 20;
        remw t2, t1, a0;
        bnez t2, check_19;
        addi a1, a1, 1;
check_19:
        li t1, 19;
        remw t2, t1, a0;
        bnez t2, check_18;
        addi a1, a1, 1;
check_18:
        li t1, 18;
        remw t2, t1, a0;
        bnez t2, check_17;
        addi a1, a1, 1;
check_17:
        li t1, 17;
        remw t2, t1, a0;
        bnez t2, check_16;
        addi a1, a1, 1;
check_16:
        li t1, 16;
        remw t2, t1, a0;
        bnez t2, check_15;
        addi a1, a1, 1;
check_15:
        li t1, 15;
        remw t2, t1, a0;
        bnez t2, check_14;
        addi a1, a1, 1;
check_14:
        li t1, 14;
        remw t2, t1, a0;
        bnez t2, check_13;
        addi a1, a1, 1;
check_13:
        li t1, 13;
        remw t2, t1, a0;
        bnez t2, check_12;
        addi a1, a1, 1;
check_12:
        li t1, 12;
        remw t2, t1, a0;
        bnez t2, check_11;
        addi a1, a1, 1;
check_11:
        li t1, 11;
        remw t2, t1, a0;
        bnez t2, check_10;
        addi a1, a1, 1;
check_10:
        li t1, 10;
        remw t2, t1, a0;
        bnez t2, not_10;
        addi a1, a1, 1;
not_10:

# a1 now holds how many times dividend/divisor evenly

        j div_loop;     # loop div_loop
div_loop_end:

        j big_loop;     # loop big_loop
big_loop_end:


        # exit
        li      a7, 93;
        ecall;


        .section ".tohost","aw",@progbits
        .globl tohost
        .globl fromhost

        .align 6
tohost: .dword 0
        .align 6
fromhost: .dword 0
