#include <stdio.h>

int test_6(int a);

int main()
{

  for(int i=-100; i<100; i++)
    {
      int ret = test_6(i);
      if ( (i&7) != ret) {
	printf("test_6(%d) should be %d, but got %d.\n",i&0x7,ret);
	return 1;
      }

    }
    
  return 0;
}
