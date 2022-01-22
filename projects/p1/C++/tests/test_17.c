#include <stdio.h>

int test_17(int a);

int bit(int d, int bit)
{
  return (d >> bit)&0x1;
}

int count(int x)
{
  int cnt=0;
  for(int i=0; i<32; i++)
    if (bit(x,i))
      cnt++;
  return cnt;
}

int main()
{

  for(int i=-999;i<20000; i++)
    {
      if (test_17(i) != count(i))
	{
	  printf("test_17(%d) produced %d but %d was expected.\n",i,test_17(i),count(i)); 
	  return 1;
	}
    }

  return 0;
}
