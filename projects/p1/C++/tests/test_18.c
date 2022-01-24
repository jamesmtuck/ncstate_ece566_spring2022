#include <stdio.h>

int test_18(int a);

int main()
{
    for(int i=-4096;i<20000; i++)
    {
        if (test_18(i) != ((i&0x0F00)>>8))
        {
            printf("test_18(%d) produced %d but %d was expected.\n",i,test_18(i),((i&0xF00)>>8));
            return 1;
        }
    }

    return 0;
}
