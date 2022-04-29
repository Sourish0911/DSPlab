#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <stdio.h>
#define MAXIMLENGTH 200


//FUNCTION TO CALCULATE THE FLOATING POINT CONVOLUTION
float *convolutionflt(float X[MAXIMLENGTH], float H[MAXIMLENGTH], float Y[MAXIMLENGTH], int lenX, int lenH, int lenY){
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
    return Y;
}

//FUNCTION TO ADD SCALAR IN FIXED POINT
int fxdAddScalar(int num1, int num2)
{
    return num1+num2;
}

//FUNCTION TO SHIFT THE BIT POSITION TO CALCULATE 2^X
int bitshift(int num,int shift)
{
    return num*(1<<shift);
}

//FUNCTION TO CALCULATE THE FIXED POINT SCALAR MULTIPLICATION
int fxdMulScalar(int num1, int q1, int num2, int q2, int resq)
{
    long long temp = (long long) num1*num2;
    int res;
    res = temp/(1<<(q1+q2-resq));
    return res;
}

//FUNCTION TO CALCULATE THE FIXED POINT CONVOLUTION
int *convolutionfxd(int X[MAXIMLENGTH], int H[MAXIMLENGTH], int Y[MAXIMLENGTH], int lenX, int lenH, int lenY, int Q)
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
    return Y;
}

//MAIN FUNCTION TO CALCULATE MSE FOR VARIOUS Q
int main(){
    //DECLARE INPUT AND OUTPUT ARRAY FOR FLOATING POINT CONVOLUTION
    float X[MAXIMLENGTH];
    float H[MAXIMLENGTH];
    float Y[MAXIMLENGTH];

    //DECLARE THE INPUT AND OUTPUT ARRAY FOR FIXED POINT CONVOLUTION
    int Xfix[MAXIMLENGTH];
    int Hfix[MAXIMLENGTH];
    int Yfix[MAXIMLENGTH];

    //DECLARE THE LENGTHS FOR INPUT AND OUTPUT ARRAYS OF THE CONVOLUTION
    int xlen = 10;
    int hlen = 25;
    int ylen = xlen +hlen -1;

    //DECLARE THE POINTERS TO PASS VALUE TO THE FUNCTION
    float *floatyConv;
    int *fixedyConv;


    float fixedToFloatY[MAXIMLENGTH];

    //SET THE ITERATION TO 10000 NUMBERS
    int niter = 10000;

    //DECLARE AND ARRAY THAT HAS Q VALUES FROM 7 TO 31
    int qValue[] = {7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27.28,29,30,31};

    //DECLARE AN ARRAY TO STORE THE ERRORS
    float errors[MAXIMLENGTH];

    // CALCULATE ERROR AND RELATED PARAMETERS FOR VARIOUS Q VALUES
    for(int q = 0;q<sizeof(qValue)/sizeof(qValue[0]);q++){

        float iterationError=0;

        //DO THE BELOW OPERATION FOR 10000 TIMES
        for(int j =0; j<niter;j++){

            float err=0;

            // Generating random numbers for X
            for (int i=0;i<xlen;i++)
            {
                X[i] = ((float)rand()/RAND_MAX)*(float)(1);
            }

            // Generating random numbers for H
            for(int i=0;i<hlen;i++)
            {
                H[i] =  ((float)rand()/RAND_MAX)*(float)(10);
            }

            // Fixed point conversion for X
            for (int i=0;i<xlen;i++)
            {
                Xfix[i] = (int)(X[i]*(1<<qValue[q]));
            }

            // Fixed point conversion for H
            for (int i=0;i<hlen;i++)
            {
                Hfix[i] = (int)(H[i]*(1<<qValue[q]));
            }
            
            // floating point convolution
            floatyConv=convolutionflt(X, H, Y, xlen, hlen, ylen);

            // fixed point convolution
            fixedyConv=convolutionfxd(Xfix, Hfix, Yfix, xlen, hlen, ylen, qValue[q]);

            // fixed point convolution output to floating point values
            for(int i=0; i<ylen; i++){
                fixedToFloatY[i] = (float)fixedyConv[i]/(1<<qValue[q]);
            }

            for(int i=0; i<ylen; i++){
                err += pow((floatyConv[i] - fixedToFloatY[i]), 2);
            }
            //AVERAGE OUT THE ERROR FROM THE ABOVE OBTAINED
            err = err/ylen;
            iterationError += err;
        }
        
        errors[q] = iterationError/niter;
        printf("Q VALUE IS : %d, Error VALUE IS : %f\n", qValue[q], iterationError/niter);
    } 

    

    return 0;
}