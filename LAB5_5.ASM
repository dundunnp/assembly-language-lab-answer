assume cs:code
a segment
        db 1,2,3,4,5,6,7,8
a ends

b segment
        db 1,2,3,4,5,6,7,8
b ends

c segment
        db 0,0,0,0,0,0,0,0
c ends

code segment
start:  mov ax, c
        mov ss, ax
        mov sp, 9
        mov ax, a
        mov ds, ax
        mov ax, b
        mov es, ax
        mov cx, 9
        mov bx, 8
s:      mov dl, [bx]
        add dl, es:[bx]
        push dl
        sub bx, 1
        loop s

        mov ax, 4c00h
        int 21h
code ends
end start
