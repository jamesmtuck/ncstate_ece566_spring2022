#include <stdio.h>

int into_ecc(int d);

int bit(int d, int bit)
{
  return (d >> bit)&0x1;
}
int into_ecc_tester(int d)
{
  d = (d&0x7ff)<<1;
  
  int p1 = bit(d,1) ^ bit(d,2) ^ bit(d,4 ) ^ bit(d,5) ^ bit(d,7) ^ bit(d,9) ^ bit(d,11);
  int p2 = bit(d,1) ^ bit(d,3) ^  bit(d,4) ^ bit(d,6) ^ bit(d,7) ^ bit(d,10) ^ bit(d,11);
  int p4 = bit(d,2) ^ bit(d,3) ^ bit(d,4) ^ bit(d,8) ^ bit(d,9) ^ bit(d,10) ^ bit(d,11);
  int p8 = bit(d,5) ^ bit(d,6) ^ bit(d,7) ^ bit(d,8) ^ bit(d,9) ^ bit(d,10) ^ bit(d,11);

  return  (bit(d,11) << 14)
        | (bit(d,10) << 13)
        | (bit(d,9) << 12)
        | (bit(d,8) << 11)
        | (bit(d,7) << 10)
        | (bit(d,6) << 9)
        | (bit(d,5) << 8)
        | (p8 << 7)
        | (bit(d,4) << 6)
        | (bit(d,3) << 5)
        | (bit(d,2) << 4)
        | (p4 << 3)
        | (bit(d,1) << 2)
        | (p2 << 1)
        | p1;
}


int main()
{
  for(int i=0; i<10000; i++)
    {
      if (into_ecc(i) != into_ecc_tester(i))
	{
	  printf("into_ecc(%d) returned %d but %d was expected.\n",i,into_ecc(i),
		 into_ecc_tester(i));	    
	  return 1;
	}
    }
  return 0;
}
