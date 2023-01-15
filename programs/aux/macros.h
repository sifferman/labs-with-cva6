/*
 * File: macros.h
 * Description: Macros used for C programs.
 */

#ifndef __LABS_FOR_CVA6__MACROS_H
#define __LABS_FOR_CVA6__MACROS_H

#define EXIT \
    __asm__(            \
        "li a7, 93;"    \
        "ecall;"        \
    )

#endif
