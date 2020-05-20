#include <stdio.h>
#include <stdlib.h>

extern int asm_fib(int f);

int main(int argc, char **argv){

  int f = strtol(argv[1], NULL, 10);
  int fib = asm_fib(f);

  printf("The Fibonacci number of %d is %d\n", f, fib);
}
