/*
 * File: privilage.S
 * Description: Example of how to switch between different privilage modes.
 * Reference: "RISC-V Bytes: Privilege Levels" by Daniel Mangum <https://danielmangum.com/posts/risc-v-bytes-privilege-levels/>
 */

.section .text
.globl _start

_start:
.align 2
machine:
        li      t0, 0x0f;
        csrw    pmpcfg0, t0;
        li      t0, 0xc0000000;
        csrw    pmpaddr0, t0;
        la      t1, m_trap;
        csrw    mtvec, t1;
        la      t2, supervisor;
        csrw    mepc, t2;
        li      t3, (1 << 11);
        csrw    mstatus, t3;
        li      t4, 0x100;
        csrs    medeleg, t4;
        mret; # to supervisor

.align 2
m_trap:
        nop;
        ecall; # exit simulation

.align 2
supervisor:
        la      t0, user;
        csrw    sepc, t0;
        la      t1, s_trap;
        csrw    stvec, t1;
        sret; # to user

.align 2
s_trap:
        nop;
        ecall; # to m_trap

.align 2
user:
        nop;
        ecall; # to s_trap


        .data

        .section ".tohost","aw",@progbits
        .globl tohost
        .globl fromhost

        .align 6
tohost: .dword 0
        .align 6
fromhost: .dword 0
