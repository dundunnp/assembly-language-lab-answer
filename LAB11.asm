assume cs:codesg, ds:datasg

datasg segment
           db "Beginner's All-purpose Symbolic Instruction Code.", 0
datasg ends

codesg segment

    begin:  
            mov  ax, datasg
            mov  ds, ax
            mov  si, 0
            call letterc

            mov  ax, 4c00h
            int  21h
    
    letterc:
            mov  al, [si]

            cmp  al, 0
            je   ok

            cmp  al, 97
            jb   next

            cmp  al, 122
            ja   next
                
            and  byte ptr [si], 11011111b
    next:   
            inc  si
            jmp  short letterc
    ok:     
            ret

codesg ends
 
end begin