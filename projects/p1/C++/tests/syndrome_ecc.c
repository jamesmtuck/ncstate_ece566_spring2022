#include <stdio.h>

int syndrome_ecc(int d);

int bit(int d, int bit)
{
  return (d >> bit)&0x1;
}
int syndrome_ecc_tester(int d)
{
  int p1 = bit(d,0) ^ bit(d,2) ^ bit(d,4 ) ^ bit(d,6 ) ^ bit(d,8 ) ^ bit(d,10 ) ^ bit(d,12 ) ^ bit(d,14);
  int p2 = bit(d,1 ) ^ bit(d,2) ^  bit(d,5 ) ^ bit(d,6 ) ^ bit(d,9 ) ^ bit(d,10) ^ bit(d,13 ) ^ bit(d,14);
  int p4 = bit(d,3 ) ^ bit(d,4 ) ^ bit(d,5 ) ^ bit(d,6 ) ^ bit(d,11 ) ^ bit(d,12 ) ^ bit(d,13 ) ^ bit(d,14);
  int p8 = bit(d,7 ) ^ bit(d,8 ) ^ bit(d,9 ) ^ bit(d,10 ) ^ bit(d,11 ) ^ bit(d,12 ) ^ bit(d,13 ) ^ bit(d,14);
  return p8 << 3 | p4 << 2 | p2 << 1 | p1;
}


int main()
{
  for(int i=0; i<10000; i++)
    {
      if (syndrome_ecc(i) != syndrome_ecc_tester(i))
	{
	  printf("syndrome_ecc(%d) returned %d but %d was expected.\n",i,syndrome_ecc(i),
		 syndrome_ecc_tester(i));	    
	  return 1;
	}
    }
  return 0;
}
