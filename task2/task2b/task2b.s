section .data
    flag1 db '-w'
    flag2 db '-ws'
section .text

    global _start
    extern cmpstr
    extern _printer
    extern write
    extern _printflagw
    extern _printflagws

_start:
    pop ebx
    cmp ebx, 3
    je w
    jg ws
    jl none

w:
    pop ebx
    pop ebx
    call _printflagw
    mov eax,1
    int 0x80

ws:
    pop ebx
    pop ebx
    call _printflagws
    mov eax,1
    int 0x80


none:
    pop ebx
    call _printer
    mov	eax,1
    int 0x80
