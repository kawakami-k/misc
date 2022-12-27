#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

void print_fpsr() {
  uint64_t hoge;
  asm("mrs %0, fpsr" : "=r"(hoge));
  printf("0x%x\n", hoge);
}
  

int main(const int argc, const char *argv[]) {
  float nan32 = atof(argv[1]);

  if(nan32 == 0.0)
    nan32 = NAN;
  
  double nan64 = (double) nan32;
  long double nan128 = (long double) nan32;

  const float b32 = atof(argv[2]);
  const double b64 = (double) b32;
  const long double b128 = (long double) b32;

  print_fpsr();
  printf("%d\n", isless(nan32, b32));
  print_fpsr();
  printf("%d\n", isless(nan64, b64));
  print_fpsr();
  printf("%d\n", isless(nan128, b128));
  print_fpsr();

  /* fcc(trad) checks if args are NaN or not, then compares arg[0] and arg[1]).
     If doesn't set FE_INVALID.
     fcc(clang) doesn't check if args are NaN or not, and compares arg[0] and arg[1].
     If set FE_INVALID, if either arg[0] or arg[1] is NaN. 
     It seems that fcc(clang) doesn't comply with C11. */
  return isless(nan128, b128);
}
