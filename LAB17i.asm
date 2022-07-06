assume cs:code

code segment
    start:     
               mov  ax,cs
               mov  ds,ax
               mov  si,offset int7ch
               mov  ax,0
               mov  es,ax
               mov  di,200h
               mov  cx,offset int7ch_end - offset int7ch
               cld
               rep  movsb
	
               cli
               mov  word ptr es:[7ch*4],200h
               mov  word ptr es:[7ch*4+2],0
               sti

               mov  ax,4c00h
               int  21h
	
    int7ch:    
               push cx
               push dx
               push bx
               push ax

               mov  ax,dx
               mov  dx,0
               mov  bx,1440
               div  bx
               mov  cl,al                                   ;面号，先存在cl中

               mov  ax,dx                                   ;dx=rem(逻辑扇区号/1440)
               mov  dh,cl                                   ;将暂存在cl中的面号存在dh中
               mov  dl,0                                    ;驱动器号，软驱 0

               mov  bl,18
               div  bl                                      ;div bl=rem((逻辑扇区号/1440)/18)
               mov  ch,al                                   ;磁道号。al=int(rem(逻辑扇区号/1440)/18)

               inc  ah                                      ;ah=rem(rem(逻辑扇区号/1440)/18)
               mov  cl,ah                                   ;扇区号

               pop  ax
               push ax
               mov  al,0                                    ;读写扇区数
               cmp  ah,0
               je   read
               cmp  ah,1
               je   write

    read:      
               mov  ah,2
               jmp  short ok
    write:     
               mov  ah,3
               jmp  short ok
    ok:        
               int  13h
               pop  ax
               pop  bx
               pop  dx
               pop  cx

               iret
    int7ch_end:
               nop

code ends
end start


