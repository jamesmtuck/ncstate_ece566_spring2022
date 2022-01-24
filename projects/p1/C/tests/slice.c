#include <stdio.h>


int bit(int d, int bit)
{
    return (d >> bit)&0x1;
}

int set_bit(int d, int bit)
{
    return d | (1 << (bit));
}
int clear_bit(int d, int bit)
{
    return d & (~(1 << (bit)));
}
int myslice(int a) {
    a = set_bit(a,10);
    a = set_bit(a,6);
    a = set_bit(a,4);
    a = clear_bit(a,1);
    return a;
}

int slice(int);

int main()
{

    for(int i=-999;i<20000; i++)
    {
        if (slice(i) != myslice(i))
        {
            printf("slice(%d) produced %d but %d was expected.\n",i,slice(i),myslice(i));
            return 1;
        }
    }

    return 0;
}
