[org 0x100]

mov ax, 0xb800
mov es, ax

main:
    mov al, 00h
	mov ah, 0
	int 10h


    mov ah, 0
    int 0x16

    mov al, 03h
	mov ah, 0
	int 10h

mov ax, 0x4c00
int 0x21