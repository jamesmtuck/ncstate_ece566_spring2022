#include <stdio.h>

int test_8(int x, int y);

int test_8_tester(int x, int y)
{
  return (((x*y%115) / 7)+1)*2 + 1;
}

int main()
{

  for(int i=-100; i<100; i++)
    {
      int ret = test_8(i,i/2);
      if ( test_8_tester(i,i/2) != ret) {
	printf("test_8(%d) should be %d, but got %d.\n",i,test_8_tester(i,i/2),ret);
	return 1;
      }

    }
    
  return 0;
}
