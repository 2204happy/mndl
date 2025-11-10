global _start

section .text

_start:
    call main
    
    mov rax,0x3c
    mov rdi,0x0
    syscall

cmplxAdd:
    faddp st2,st0
    faddp st2,st0
    ret
    
cmplxMul:
    .r equ 0
    .i equ 8
    .c1r equ 16
    .c1i equ 24
    .c2r equ 32
    .c2i equ 40
    sub rsp,48
    
    fstp qword [rsp+.c2i]
    fstp qword [rsp+.c2r]
    fstp qword [rsp+.c1i]
    fst qword [rsp+.c1r]
    
    fmul qword [rsp+.c2r]
    fld qword [rsp+.c1i]
    fmul qword [rsp+.c2i]
    
    fsubp st1,st0
    fstp qword [rsp+.r]
    
    fld qword [rsp+.c1r]
    fmul qword [rsp+.c2i]
    fld qword [rsp+.c1i]
    fmul qword [rsp+.c2r]
    
    faddp st1,st0
    
    fstp qword [rsp+.i]
    
    fld qword [rsp+.r]
    fld qword [rsp+.i]
    
    add rsp,48
    ret

    
cmplxPow:;rax = exponent
    .r equ 0
    .i equ 8
    sub rsp,16
    
    cmp rax,0x0
    jne .powRecur
        fstp qword [rsp+.i]
        fstp qword [rsp+.r]
        fld1
        fldz
        add rsp,16
        ret
    .powRecur
        fst qword [rsp+.i]
        fxch st1
        fst qword [rsp+.r]
        fxch st1
        dec rax
        push qword [rsp+.r]
        push qword [rsp+.i]
        call cmplxPow
        pop qword [rsp+.i]
        pop qword [rsp+.r]
        fld qword [rsp+.r]
        fld qword [rsp+.i]
        call cmplxMul
        add rsp,16
        ret

    
cmplxAbs:
    fmul st0,st0
    fxch st1
    fmul st0,st0
    faddp st1,st0
    fsqrt
    ret
    
mndl:;rcx = i
    .r equ 0
    .i equ 8
    sub rsp,16

    cmp rcx,0x0
    jne .mndlRecur
        add rsp,16
        ret
    .mndlRecur
        fst qword [rsp+.i]
        fxch st1
        fst qword [rsp+.r]
        fxch st1
        push qword [rsp+.r]
        push qword [rsp+.i]
        dec rcx
        call mndl
        pop qword [rsp+.i]
        pop qword [rsp+.r]
        mov rax,0x2
        call cmplxPow
        fld qword [rsp+.r]
        fld qword [rsp+.i]
        call cmplxAdd
        add rsp,16
        ret
        
printChar:
    mov rax,0x1
    mov rdi,0x1
    mov rdx,0x1
    syscall
    ret
    
main:
    .r equ 0
    .i equ 8
    .tmp equ 16
    
    sub rsp,24

    fld1
    fidiv dword [step]
    fstp qword [step]
    fld1
    .loop1 ficom dword [imEnd]
        fnstsw ax
        and ah,0b01000111
        cmp ah,0x1
        je .end1
        fild qword [rStart]
        .loop2 ficom dword [rEnd]
            fnstsw ax
            and ah,0b01000111
            cmp ah,0x0
            je .end2
            fst qword [rsp+.r]
            fxch st1
            fst qword [rsp+.i]
            mov rcx,0x1e
            call mndl
            call cmplxAbs
            fxam
            fnstsw ax
            and ah,0b01000111
            cmp ah,0x40
            jge .inMndl
            cmp ah,0x4
            jne .notInMndl
            ficom dword [uBound]
            fnstsw ax
            and ah,0b01000111
            cmp ah,0x0
            je .notInMndl
            .inMndl mov rsi,inMndl
                jmp .loop2cont
            .notInMndl
                mov rsi,outMndl
            .loop2cont
            call printChar
            fstp qword [rsp+.tmp]
            fld qword [rsp+.i]
            fld qword [rsp+.r]
            fadd qword [step]
            jmp .loop2
        .end2
        mov rsi,nl
        call printChar
        fstp qword [rsp+.tmp]
        fsub qword [step]
        jmp .loop1
    .end1 add rsp,24
    ret
    

    
section .data
    inMndl: db "O"
    outMndl: db " "
    nl: db 0xa
    rStart: dq -0x2
    rEnd: dd 0x1
    imEnd: dd -0x1
    uBound: dd 0x3e8
    step: dd 0x20,0x0
