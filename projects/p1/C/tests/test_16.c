#include <stdio.h>

int test_16(int x, int y);

int abs(int x)
{
  return ((x >> 31) ^ x) + ((x>>31)&0x1);
}

int test_16_tester(int x, int y)
{
  int t = (abs(x)-abs(y));
  return t*t;
}

int main()
{
  int i = 10;
  int j = -15;

  for(;i<20; i++,j++)
    {
      if (test_16(i,j) != test_16_tester(i,j))
	{
	  printf("test_16(%d,%d) produced %d but %d was expected.\n",i,j,test_16(i,j),test_16_tester(i,j)); 
	  return 1;
	}
    }

  return 0;
}
