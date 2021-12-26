[org 0x100]

mov ax, 0xb800
mov es, ax

jmp main

; you win function
splash:
    pusha
    mov al, 00h
    mov ah, 0
    int 10h

    mov di, 0
    mov cx, 1000
    mov ax, 0x2220
    rep stosw

    ; code to print string
    mov word[es:990], 0x2f59 ; Y
    mov word[es:992], 0x2f4f ; O
    mov word[es:994], 0x2f55 ; U
    mov word[es:1002], 0x2f57 ; W
    mov word[es:1004], 0x2f49 ; I
    mov word[es:1006], 0x2f4e ; N

    call delay
    call delay
    call delay
    call delay

    mov al, 03h
	mov ah, 0
	int 10h
    popa
ret


main:
    call winfunc
    mov ah, 0
    int 0x16
    jmp main
mov ax, 0x4c00
int 0x21