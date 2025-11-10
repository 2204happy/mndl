#[derive(Copy, Clone)]
struct Cmplx {
    r: f64,
    i: f64
}

fn cmplx_add(c1: Cmplx, c2: Cmplx) -> Cmplx {
    return Cmplx {
        r: c1.r + c2.r,
        i: c1.i + c2.i
    };
}

fn cmplx_mul(c1: Cmplx, c2: Cmplx) -> Cmplx {
    return Cmplx {
        r: c1.r*c2.r - c1.i*c2.i,
        i: c1.r*c2.i + c1.i*c2.r
    };
}

fn cmplx_pow(c: Cmplx, n: i64) -> Cmplx {
    if n==0 {
        return Cmplx {
            r: 1.0,
            i: 0.0
        }
    }
    else {
        return cmplx_mul(cmplx_pow(c,n-1),c);
    }
}

fn cmplx_abs(c: Cmplx) -> f64 {
    return (c.r.powf(2.0)+c.i.powf(2.0)).sqrt();
}

fn mndl(c: Cmplx, i: i64) -> Cmplx {
    if i==0 {
        return c;
    }
    else {
        return cmplx_add(cmplx_pow(mndl(c,i-1),2),c);
    }
}

fn main() {
    let mut c = Cmplx {
        r: -2.0,
        i: 1.0
    };
    while c.i>=-1.0 {
        c.r = -2.0;
        while c.r<=1.0 {
            if cmplx_abs(mndl(c,30)) < 1000.0 {
                print!("O");
            }
            else {
                print!(" ");
            }
            c.r+=0.03125;
        }
        print!("\n");
        c.i-=0.03125;
    }
} 
