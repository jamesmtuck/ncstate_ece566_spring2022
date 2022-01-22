#include <stdio.h>

// Compile with these flags
// -DTEST=<funcname> -DRETVAL=<num>

// Or define these macros as appropriate:
//#define FUNC test_0
//#define RETVAL 0

int TEST();

#ifndef RETVAL
#define RETVAL 0
#endif

int main()
{
  int ret = TEST();
  if(ret!=RETVAL)
    {
      // error out; make will catch it as error
      printf("Failed ret=%d but should have been %d.\n",ret,RETVAL);
      return 1;
    }
  return 0;
}
