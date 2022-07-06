assume cs:codesg, ds:datasg

datasg segment
	db 'welcome to masm!'
datasg ends

codesg segment
start:
	mov ax, datasg
	mov ds, ax
	
	mov ax, 0B800h
	mov es, ax
	
	mov si, 0
	mov cx, 16
	mov bx, 0
s:	
	mov al, [si]
	mov ah, 42h
	mov es:[6e0h+40h+bx], ax
	
	mov ah, 24h
	mov es:[6e0h+40h+160+bx], ax		

	mov ah, 71h
	mov es:[6e0h+40h+160+160+bx], ax

	inc si
	add bx, 2
	loop s

	mov ax, 4c00h
	int 21h

codesg ends
end start