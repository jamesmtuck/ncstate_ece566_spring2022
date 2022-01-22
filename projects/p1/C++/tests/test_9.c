#include <stdio.h>

int test_9(int x);

int test_9_tester(int x)
{
  x = x & 0xFFFF;

  int and = (x==0xFFFF)?1:0;
  int or = (x > 0)?1:0;
  int xor=0;

  for(int i =0; i<16; i++)
    {
      xor ^= (( x >> i ) & 0x1);
    }

  return (and << 2) | (xor << 1) | or;
}

int main()
{

  for(int i=-100; i<100; i++)
    {
      int ret = test_9(i);
      if ( test_9_tester(i) != ret) {
	printf("test_9(%d) should be %d, but got %d.\n",i,test_9_tester(i),ret);
	return 1;
      }

    }
    
  return 0;
}
