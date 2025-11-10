class cmplx:
    def __init__(self,r,i):
        if abs(r)>2**64:
            r = float("inf")*r/abs(r)
        if abs(i)>2**64:
            i = float("inf")*i/abs(i)
        self.r = r
        self.i = i
    
    def __add__(self,c):
        r = self.r + c.r
        i = self.i + c.i
        return cmplx(r,i)
    
    def __mul__(self,c):
        r = self.r*c.r - self.i*c.i
        i = self.r*c.i + self.i*c.r
        return cmplx(r,i)
    
    def __pow__(self,n):
        if n==0:
            return cmplx(1,0)
        else:
            return self**(n-1)*self

    def abs(self):
        return (self.r**2+self.i**2)**(1/2)
    

def mndl(c,i):
    if i==0:
        return c
    else:
        return mndl(c,i-1)**2+c
    
i = 1
while i>=-1:
    r = -2
    while r<=1:
        if mndl(cmplx(r,i),30).abs() < 1000:
            print('O',end="")
        else:
            print(' ',end="")
        r+=0.03125
    print("")
    i-=0.03125
    
