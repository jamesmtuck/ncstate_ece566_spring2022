#include <stdio.h>
#include <sys/types.h>
extern int64_t test_03(int64_t,int64_t,int64_t);

int64_t test_function(int64_t a, int64_t b, int64_t c)
{
  int t0;
  int t1;
  int t2;
  t0 = a+b+c;
  t1 = 10*t0;
  t2 = t1/10;
  return t2;
}

int main()
{
  
  int i, j, k;
  int errors=0;
  int success=0;

  for (i=5; i<10; i++)
    for (j=100; j<103; j++)
      for (k=-10; k<-8; k++)
	if (test_03(i,j,k)!=test_function(i,j,k))
	  errors++;
	else
	  success++;

  printf("success,%d\nerrors,%d\ntotal,%d\n",success,errors,success+errors);

  return 0;
}
