// Online C compiler to run C program online
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

void convolutionflt(float X[25], float H[25], float Y[50], int lenX, int lenH, int lenY);
int fxdAddScalar(int num1, int num2);
int bitshift(int num,int shift);
int fxdMulScalar(int num1, int q1, int num2, int q2, int resq);
void convolutionfxd(int X[25], int H[25], int Y[50], int lenX, int lenH, int lenY, int Q);


int main() {
    // Write C code here
    srand((unsigned int)time(NULL));

    float a = 5;
    for (int i=0;i<1;i++)
        printf("%f\n", ((float)rand()/RAND_MAX)*(float)(10.0));
    float X[3] = {1,2,3};
    float H[2] = {1,2};
    float Y[25];
    convolutionflt(X,H,Y, 3, 2, 4);
    
    return 0;
}

void convolutionfxd(int X[25], int H[25], int Y[50], int lenX, int lenH, int lenY, int Q)
{
    for(int n=0;n<lenY;n++)
    {
        Y[n] = 0;
        for(int k = 0;k<=n;k++)
        {
        if((n-k)>=lenH || k>=lenX)
        continue;
        Y[n] = fxdAddScalar(bitshift(Y[n],0),fxdMulScalar(X[k],Q,H[n-k],Q,Q));
        }
    }
}
void convolutionflt(float X[25], float H[25], float Y[50], int lenX, int lenH, int lenY){
    for(int n=0;n<lenY;n++)
    {
        Y[n] = 0;
        for(int k = 0;k<=n;k++)
        {
        if((n-k)>=lenH || k>=lenX)
        continue;
        Y[n] = Y[n] + (X[k]*H[n-k]);
        }
    }
}

int fxdAddScalar(int num1, int num2)
{
    return num1+num2;
}

int bitshift(int num,int shift)
{
    return num*(1<<shift);
}

int fxdMulScalar(int num1, int q1, int num2, int q2, int resq)
{
    long long temp = (long long) num1*num2;
    int res;
    res = temp/(1<<(q1+q2-resq));
    return res;
}


