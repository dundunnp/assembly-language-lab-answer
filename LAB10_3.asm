assume cs:code, ds:data, ss:stack

data segment
         db 10 dup (0)
data ends

stack segment
          dw 8 dup(0)
stack ends

code segment
    start:   
             mov  bx, data
             mov  ds, bx
             mov  si, 0
             mov  ax, stack
             mov  ss, ax
             mov  sp, 16
             mov  ax, 45789
             call dtoc

             mov  dh, 8
             mov  dl, 3
             mov  cl, 2
             call show_str

             mov  ax, 4c00h
             int  21h
    dtoc:    
             mov  dx, 0
             mov  bx, 10
             div  bx
             add  dx, 30h
             push dx
             inc  si
             mov  cx, ax
             jcxz reverse
             jmp  short dtoc
    reverse: 
             mov  cx, si
             mov  si, 0
    s:       
             pop  [si]
             inc  si
             loop s

             mov  byte ptr [si], 0
             ret

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