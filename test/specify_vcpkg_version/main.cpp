#include <uchardet.h>

int main() {
  uchardet_t detector = uchardet_new();
  if (!detector) {
    return 1;
  }
  uchardet_delete(detector);
  return 0;
}
