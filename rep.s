
        .text
        .globl _start;
_start:
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;
        addi t0, zero, 1;


        # li    a7, 93;           # set syscall to `exit`
        # li    a0, 0;            # exit code `0`
        ecall

        .data
