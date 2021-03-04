#include <inttypes.h>
#include <stdio.h>

int64_t entry();

int main(void) {
  int64_t result = entry();
  printf("%ld \n", result);
  return 0;
}
