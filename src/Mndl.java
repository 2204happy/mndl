public class Mndl {
    public static void main(String[] args) {
        Cmplx c = new Cmplx(-2,1);
        while (c.i>=-1) {
            c.r = -2;
            while (c.r<=1) {
                if (mndl(c,30).abs() < 1000) {
                    System.out.print('O');
                }
                else {
                    System.out.print(' ');
                }
                c.r+=0.03125;
            }
            System.out.print('\n');
            c.i-=0.03125;
        }
    }
    
    static Cmplx mndl(Cmplx c,int i) {
        if (i==0) {
            return c;
        }
        else {
            return mndl(c,i-1).pow(2).add(c);
        }
    }
}

class Cmplx {
    public double r;
    public double i;
    
    public Cmplx(double r,double i) {
        this.r = r;
        this.i = i;
    }
    
    public Cmplx add(Cmplx other) {
        double r = this.r+other.r;
        double i = this.i+other.i;
        return new Cmplx(r,i);
    }
    
    public Cmplx mul(Cmplx other) {
        double r = this.r*other.r - this.i*other.i;
        double i = this.r*other.i + this.i*other.r;
        return new Cmplx(r,i);
    }
    
    public Cmplx pow(int n) {
        if (n==0) {
            return new Cmplx(1,0);
        }
        else {
            return this.mul(this.pow(n-1));
        }
    }
    
    public double abs() {
        return Math.sqrt(Math.pow(this.r,2)+Math.pow(this.i,2));
    }
}
