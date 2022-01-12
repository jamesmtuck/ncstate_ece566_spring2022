#include <stdio.h>
#include <sys/types.h>

extern int64_t test_09(int64_t,int64_t,int64_t);

int64_t test_function(int64_t choose, int64_t x, int64_t y)
{
  if (y==0)
    y = y+1;

  if (choose)
    return x / y;
  else
    return x % y;
}

int main()
{
  
  int64_t i, j, k;
  int errors=0;
  int success=0;

  for (i=-2,j=10; i<20; i++,j--)
    if (test_09(j>2,i,j)!=test_function(j>2,i,j))
	  errors++;
	else
	  success++;

  printf("success,%d\nerrors,%d\ntotal,%d\n",success,errors,success+errors);

  return 0;
}
