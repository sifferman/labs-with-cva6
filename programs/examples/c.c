/*
 * File: c.c
 * Description: Example of how to format a C file to be read by CVA6.
 */

#include "program_stop.h"

const char str[] = "Hello, world!";

int f(int x, int y) {
    return x + y;
}

// entry point
void _start(void) {
    int result = f(2022, 2023);
    program_stop(0);
}
