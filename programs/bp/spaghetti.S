/*
 * File: spaghetti.S
 * Description: Spaghetti code to benchmark the branch predictor.
 */

        .text
# Text segment
        .globl _start;
_start: # entry point
        li      t0, 30;                 # big_loop init
big_loop:
        addi    t0, t0, -1;             # big_loop counter
        beqz    t0, big_loop_end;       # big_loop exit condition



spaghetti_0:
        li t1, 1;
        li t2, 2;
label1_0: bgt t1, t2, label3_0;
label2_0: ble t1, t2, label4_0;
label6_0: bne t1, t2, label5_0;
label3_0: bgtu t1, t2, label5_0;
label4_0: bleu t1, t2, label6_0;
label5_0: beq t1, t2, label7_0;
label7_0: blt t1, t2, label9_0;
label8_0: bge t1, t2, labelA_0;
label9_0: bltu t1, t2, spaghetti_1;
labelA_0: bgeu t1, t2, spaghetti_1;

spaghetti_1:
        li t1, 2;
        li t2, 1;
label1_1: bgt t1, t2, label3_1;
label2_1: ble t1, t2, label4_1;
label7_1: blt t1, t2, label5_1;
label3_1: bgtu t1, t2, label5_1;
label4_1: bleu t1, t2, label6_1;
label5_1: beq t1, t2, label7_1;
label6_1: bne t1, t2, label8_1;
label8_1: bge t1, t2, labelA_1;
label9_1: bltu t1, t2, label8_1;
labelA_1: bgeu t1, t2, spaghetti_2;

spaghetti_2:
        li t1, 0;
        li t2, 0;
label1_2: bgt t1, t2, label3_2;
label2_2: ble t1, t2, label4_2;
label8_2: bge t1, t2, label5_2;
label3_2: bgtu t1, t2, label5_2;
label4_2: bleu t1, t2, label6_2;
label5_2: beq t1, t2, label7_2;
label6_2: bne t1, t2, label8_2;
label7_2: blt t1, t2, label9_2;
label9_2: bltu t1, t2, done;
labelA_2: bgeu t1, t2, done;

done:


        j big_loop;                     # loop big_loop
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
