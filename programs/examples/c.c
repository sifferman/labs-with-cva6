/*
 * File: c.c
 * Description: Example of how to format a C file to be read by CVA6.
 */

const char str[] = "Hello, world!";

int f(int x, int y) {
    return x + y;
}

// entry point
int _start(void) {
    int result = f(2022, 2023);
    return 0;
}
