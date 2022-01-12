#include <stdio.h>
#include <sys/types.h>
extern int64_t test_10(int64_t *x, int64_t size);

int64_t test_function(int64_t *x, int64_t size)
{
  int64_t j;
  int64_t sum;
  sum=0;

  for(j=0; j<size; j++)
    sum = sum + x[j];

  return sum;
}

int main()
{
  
  int i, j, k;
  int errors=0;
  int success=0;

  int64_t array[100];

  for(i=0; i<100; i++)
    {
      array[i] = i;
    }

  for (i=10; i<20; i++)
    if (test_10(array+i,i*2)!=test_function(array+i,i*2))
	  errors++;
    else
      success++;

  printf("success,%d\nerrors,%d\ntotal,%d\n",success,errors,success+errors);

  return 0;
}
