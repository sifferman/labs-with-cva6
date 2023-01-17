/*
 * File: fib.c
 * Description: Fibonacci sequence generation to benchmark the branch predictor.
 */

#include "macros.h"

int fib(int x) {
    if (x==1) return 1;
    if (x==0) return 0;
    if (x<0) return -1;
    return fib(x-1) + fib(x-2);
}

void _start(void) {
    int i = 0;
    for (i = 0; i < 5; i++)
        fib(i);
    EXIT;
}
