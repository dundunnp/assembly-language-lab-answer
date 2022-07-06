assume cs:codesg,ds:datasg,es:tablesg,ss:stacksg

datasg segment
                db '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985'
                db '1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'


                dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514,345980,590827
                dd 803530,1183000,1843000,2759000,3753000,4649000,5937000


                dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
                dw 11542,14430,15257,17800
datasg ends


tablesg segment
                db 21 dup ('year summ ne ?? ')
tablesg ends

stacksg segment
	dw 0,0,0,0,0,0,0,0
stacksg ends


codesg segment

start:
	mov ax, datasg
	mov ds, ax
	
	mov ax, stacksg
	mov ss, ax
	mov sp, 16
	
	mov ax, tablesg
	mov es, ax
	
	mov di, 0
	mov si, 0
	mov bx, 0
	mov cx, 21
s0:	
	push cx
	push bx
	mov bx, 0
	mov cx, 4
s1:	
	mov al, [di]
	mov es:[si][bx], al
	mov al, 54h[di]
	mov es:[si].05h[bx], al
	inc bx
	inc di
	loop s1

	pop bx
	mov ax, 0a8h[bx]
	mov es:[si].0ah, ax
	add bx, 2
	add si, 16

	pop cx
	loop s0
	
	
	mov si, 0
	mov cx, 15h
s2:	
	mov ax, es:[si].05h
	mov dx, es:[si].07h
	div word ptr es:[si].0ah
	mov es:[si].0dh, ax
	add si, 16
	loop s2

	mov ax, 4c00h
	int 21h
codesg ends

end start
