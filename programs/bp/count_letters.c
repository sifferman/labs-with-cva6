/*
 * File: count_letters.c
 * Description: Function to count the number of english letters in each number 0-99 to benchmark the branch predictor.
 */

#include "macros.h"

int count_letters(int x) {
    if(x<0||x>99) return 0; // not supported
    if(x==0) return 4;  // zero
    if(x==1) return 3;  // one
    if(x==2) return 3;  // two
    if(x==3) return 5;  // three
    if(x==4) return 4;  // four
    if(x==5) return 4;  // five
    if(x==6) return 3;  // six
    if(x==7) return 5;  // seven
    if(x==8) return 5;  // eight
    if(x==9) return 4;  // nine
    if(x==10) return 3; // ten
    if(x==11) return 6; // eleven
    if(x==12) return 6; // twelve
    if(x==13) return 8; // thirteen
    if(x==14) return 8; // fourteen
    if(x==15) return 7; // fifteen
    if(x==16) return 7; // sixteen
    if(x==17) return 9; // seventeen
    if(x==18) return 8; // eighteen
    if(x==19) return 8; // nineteen
    if(x==20) return 6; // twenty
    if(x==30) return 6; // thirty
    if(x==40) return 5; // fourty
    if(x==50) return 5; // fifty
    if(x==60) return 5; // sixty
    if(x==70) return 7; // seventy
    if(x==80) return 6; // eighty
    if(x==90) return 6; // ninety
    int ones = x%10;
    return
        count_letters(x-ones)   // tens place
      + 1                       // hyphen
      + count_letters(ones);    // ones place
}

void _start(void) {
    int i = 0;
    for (i = 0; i < 100; i++)
        count_letters(i);
    EXIT;
}
