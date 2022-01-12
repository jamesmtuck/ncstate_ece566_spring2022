#include <stdio.h>
#include <sys/types.h>
extern int64_t test_13(int64_t);

int64_t test_function(int64_t x)
{
  int64_t *i;
  i = &x;
  *i = x+1;
  return *i;
}

int main()
{
  
  int64_t i, j, k;
  int errors=0;
  int success=0;

  for (i=-2; i<20; i++)
    if (test_13(i)!=test_function(i))
	  errors++;
	else
	  success++;

  printf("success,%d\nerrors,%d\ntotal,%d\n",success,errors,success+errors);

  return 0;
}
