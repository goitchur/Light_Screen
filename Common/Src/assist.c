#include "assist.h"

void MemSet(unsigned char *src, unsigned char value, unsigned int len)
{
    unsigned int i;

    for(i = 0; i < len; i++)
    {
        src[i] = value;
    }
}

void MemCpy(unsigned char *src, unsigned char *des, unsigned int len)
{
    unsigned int i;

    for(i = 0; i < len; i++)
    {
        src[i] = des[i];
    }
}

