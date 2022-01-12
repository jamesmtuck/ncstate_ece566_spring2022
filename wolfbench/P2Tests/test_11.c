#include <stdio.h>
#include <sys/types.h>
extern int64_t test_11(int64_t);

int64_t test_function(int64_t x)
{
  int64_t j;
  int64_t i;
  int64_t sum;
  sum=0;
  for(j=0; j<10; j++)
    for(i=0; i<5; i++)
      sum = sum + x;

  return sum;
}

int main()
{
  
  int64_t i, j, k;
  int errors=0;
  int success=0;

  for (i=-2; i<20; i++)
	if (test_11(i)!=test_function(i))
	  errors++;
	else
	  success++;

  printf("success,%d\nerrors,%d\ntotal,%d\n",success,errors,success+errors);

  return 0;
}
