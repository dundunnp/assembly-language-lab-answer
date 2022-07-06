assume cs:code

code segment

    start:   
             mov  ax, cs
             mov  ds, ax
             mov  si, offset do0
             mov  ax, 0
             mov  es, ax
             mov  di, 200h
             mov  cx, offset do0end-offset do0
             cld
             rep  movsb

             mov  ax, 0
             mov  es, ax
             mov  word ptr es:[7ch*4], 200h
             mov  word ptr es:[7ch*4+2], 0

             mov  ax, 4c00h
             int  21h
    
    do0:     
             push ax
             push es
             push di
             push bx
             push cx
             push si

             mov  ax, 0b800h
             mov  es, ax
             mov  di, 0

             mov  ax, 160
             mul  dh
             add  di, ax

             mov  ax, 2
             mul  dl
             add  di, ax

             mov  bl, cl
    do0start:
             mov  cl, [si]
             mov  ch, 0
             jcxz ok
        
             mov  es:[di], cl
             mov  es:[di+1], bl
        
             add  di, 2
             inc  si

             jmp  short do0start
    ok:      
             pop  si
             pop  cx
             pop  bx
             pop  di
             pop  es
             pop  ax
        
             iret
    do0end:  
             nop

code ends
end start