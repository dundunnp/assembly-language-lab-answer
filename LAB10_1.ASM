assume cs:code

data segment
         db "Welcome to masm!", 0
data ends

code segment
    start:   
             mov  dh, 12
             mov  dl, 40
             mov  cl, 87
             mov  ax, data
             mov  ds, ax
             call show_str

             mov  ax, 4c00h
             int  21h
    show_str:
             mov  si, 0
             mov  di, 0
             mov  ax, 0B800h
             mov  es, ax
             mov  bx, 0
             dec  dh
             dec  dl
             mov  al, 160
             mul  dh
             add  bx, ax
             mov  al, 2
             mul  dl
             add  bx, ax
    print:   
             push cx
             mov  cl, [si]
             mov  ch, 0
             jcxz ok
             pop  cx

             mov  ch, 0
             mov  ax, ds:[si]
             mov  es:[bx+di], ax
             mov  es:[bx+di+1], cx

             inc  si
             add  di, 2
             jmp  short print

    ok:      
             pop  cx
             ret
code ends
end start
