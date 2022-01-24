#include <stdio.h>

int test_19(int a);

int swap(int a) {
    return ((a&0xFF) << 24) | ((a&0xFF00) << 8) | ((a&0xFF000000)>>24) | ((a&0xFF0000)>>8);
}

int main()
{
    for(int i=16;i<20000; i++)
    {
        if (test_19(i) != (swap(i)))
        {
            printf("test_19(%d) produced %d but %d was expected.\n",i,test_19(i),swap(i));
            return 1;
        }
    }

    return 0;
}
