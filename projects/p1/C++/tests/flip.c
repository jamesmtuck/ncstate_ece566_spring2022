#include <stdio.h>

int flip(int d, int pos);
int flip_tester(int d, int pos)
{
  d = d ^ (1 << pos);
  return d;
}


int main()
{
  for(int i=0; i<10000; i++)
    {
      for(int j=0; j<5; j++)
	if (flip(i,j) != flip_tester(i,j))
	  {
	    printf("flip(%d,%d) returned %d but %d was expected.\n",i,j,flip(i,j),flip_tester(i,j));	    
	    return 1;
	  }
    }
  return 0;
}
