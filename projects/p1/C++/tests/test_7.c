#include <stdio.h>

int test_7(int a);

int test_7_tester(int a)
{
  unsigned int b = (unsigned) (a*a - a);
  return (b>>5) & (0xFF);
}

int main()
{

  for(int i=-100; i<100; i++)
    {
      int ret = test_7(i);
      if ( test_7_tester(i) != ret) {
	printf("test_7(%d) should be %d, but got %d.\n",i,test_7_tester(i),ret);
	return 1;
      }

    }
    
  return 0;
}
