#include <iostream>
#include <cmath>

class Cmplx {
    public:
        double r;
        double i;
        
        Cmplx(double r, double i) {
            this->r = r;
            this->i = i;
        }
    
        Cmplx operator+(Cmplx& other) {
            return Cmplx(this->r+other.r,this->i+other.i);
        }
        
        Cmplx operator*(Cmplx& other) {
            Cmplx res = Cmplx(0,0);
            res.r = this->r*other.r - this->i*other.i;
            res.i = this->r*other.i + this->i*other.r;
            return res;
        }
        
        Cmplx pow(int n) {
            if (n==0) {
                return Cmplx(1,0);
            }
            else {
                return this->pow(n-1)*(*this);
            }
        }
        
        double abs() {
            return std::sqrt(std::pow(this->r,2)+std::pow(this->i,2));
        }
};

Cmplx mndl(Cmplx c,int i) {
    if (i==0) {
        return c;
    }
    else {
        return mndl(c,i-1).pow(2)+c;
    }
}

int main() {
    Cmplx c = Cmplx(-2,1);
    while (c.i>=-1) {
        c.r = -2;
        while (c.r<=1) {
            if (mndl(c,30).abs() < 1000) {
                std::cout << "O";
            }
            else {
                std::cout << " ";
            }
            c.r+=0.03125;
        }
        std::cout << std::endl;
        c.i-=0.03125;
    }
    return 0;
}
