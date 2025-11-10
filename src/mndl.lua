function cmplxAdd(c1,c2)
    return {
        r = c1["r"]+c2["r"],
        i = c1["i"]+c2["i"]
    }
end

function cmplxMul(c1,c2)
    return {
        r = c1["r"]*c2["r"] - c1["i"]*c2["i"],
        i = c1["r"]*c2["i"] + c1["i"]*c2["r"]
    }
end

function cmplxPow(c,n)
    if n==0 then
        return {
            r = 1,
            i = 0
        }
    else
        return cmplxMul(cmplxPow(c,n-1),c)
    end
end
    
function cmplxAbs(c)
    return math.sqrt(c["r"]^2+c["i"]^2)
end
    
function mndl(c,i)
    if i==0 then
        return c
    else
        return cmplxAdd(cmplxPow(mndl(c,i-1),2),c)
    end
end

c = {
    r = -2,
    i = 1
}

while c["i"]>=-1 do
    c["r"] = -2
    while c["r"]<=1 do
        if cmplxAbs(mndl(c,30)) < 1000 then
            io.write("O")
        else
            io.write(" ")
        end
        c["r"] = c["r"] + 0.03125
    end
    io.write("\n")
    c["i"] = c["i"] - 0.03125
end
