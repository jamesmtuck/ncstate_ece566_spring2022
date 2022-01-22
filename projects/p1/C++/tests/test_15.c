#include <stdio.h>

int test_15(int a);

int test_15_tester(int a)
{
  return (a&0xFFF) >> 1;
}

int main()
{

  for(int i=0; i<100; i++)
    {
      int ret = test_15(i);
      if ( test_15_tester(i) != ret) {
	printf("test_15(%d) should be %d, but got %d.\n",i,test_15_tester(i),ret);
	return 1;
      }

    }
    
  return 0;
}
