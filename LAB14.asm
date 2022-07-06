assume cs:code

data segment
         db 'yy/mm/ss hh:mm:ss', 0    ;输出模板
data ends

code segment
    start:          
                    mov  ax, data
                    mov  ds, ax
                    mov  si, 0                  ;初始化输出模板

                    mov  bx, 9                  ;方便循环操作
                    mov  dx, 3                  ;计数
                    mov  cl, 4

    y_m_s:          
                    mov  al, bl
                    out  70h, al                ;给70h端口送入9,访问CMOS-9号地址
                    in   al, 71h                ;拿出9号地址中间的内容
                    mov  ah, al

                    shr  ah, cl                 ;只需要前面4个字节
                    and  al, 00001111b          ;只需要后面4个字节

                    add  ah, 30h
                    add  al, 30h

                    mov  [si], ah               ;放入模板字符串中
                    mov  [si+1], al
                    add  si, 3
                    dec  bx
                    dec  dx

                    cmp  dx, 0                  ;判断循环是否结束
                    je   h_m_s_start

                    jmp  short y_m_s

    h_m_s_start:    
                    mov  bx, 4
                    mov  dx, 3

    h_m_s:          
                    mov  al, bl
                    out  70h, al
                    in   al, 71h
                    mov  ah, al

                    shr  ah, cl
                    and  al, 00001111b

                    add  ah, 30h
                    add  al, 30h

                    mov  [si], ah
                    mov  [si+1], al
                    add  si, 3
                    sub  bx, 2
                    dec  dx

                    cmp  dx, 0
                    je   print_str_start
                    jmp  short h_m_s

    print_str_start:
                    call print_str

                    mov  ax, 4c00h
                    int  21h
    print_str:      
                    push es
                    push ax
                    push cx
                    push di
                    push si

                    mov  ax, 0b800h
                    mov  es, ax                 ;初始化显存

                    mov  si, 0
                    mov  di, 36*2               ;确定列
                    mov  cx, 0                  ;结束输入的条件

    print_loop:     
                    mov  cl, [si]
                    jcxz print_ok
                    mov  es:[160*12][di], cl
                    inc  si
                    add  di, 2

                    jmp  short print_loop

    print_ok:       
                    pop  si
                    pop  di
                    pop  cx
                    pop  ax
                    pop  es
                    ret

code ends
end start