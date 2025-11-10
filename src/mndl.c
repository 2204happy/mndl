#include <stdio.h>
#include <float.h>
#include <math.h>

typedef struct {
    double r;
    double i;
} cmplx;

cmplx cmplxAdd(cmplx c1,cmplx c2) {
    cmplx res;
    res.r = c1.r + c2.r;
    res.i = c1.i + c2.i;
    return res;
}

cmplx cmplxMul(cmplx c1,cmplx c2) {
    cmplx res;
    res.r = c1.r*c2.r - c1.i*c2.i;
    res.i = c1.r*c2.i + c1.i*c2.r;
    return res;
}

cmplx cmplxPow(cmplx c,int n) {
    if (n==0) {
        cmplx one;
        one.r = 1;
        one.i = 0;
        return one;
    }
    else {
        return cmplxMul(cmplxPow(c,n-1),c);
    }
}

double cmplxAbs(cmplx c) {
    return sqrt(pow(c.r,2)+pow(c.i,2));
}

cmplx mndl(cmplx c,int i) {
    if (i==0) {
        return c;
    }
    else {
        return cmplxAdd(cmplxPow(mndl(c,i-1),2),c);
    }
}

int main() {
    cmplx c;
    c.i = 1;
    while (c.i>=-1) {
        c.r = -2;
        while (c.r<=1) {
            if (cmplxAbs(mndl(c,30)) < 1000) {
                putchar('O');
            }
            else {
                putchar(' ');
            }
            c.r+=0.03125;
        }
        putchar('\n');
        c.i-=0.03125;
    }
    return 0;
}
