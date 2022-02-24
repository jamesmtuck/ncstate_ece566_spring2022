#include <stdio.h>

struct X {
  int x;
  int y;
  double j;
};

int main() {
  struct X x;
  x.x=5;
  x.y=10;
  int z;

  x.x=25;
  if (x.y>100)
    x.x -= 2;

  z = x.x;

//printf("%d %d\n",x.x,x.y);
  
  return 0;
}
