[org 0x100]

jmp main

; subroutine to print score on top left
score:
    push bp
    mov bp, sp
    pusha

    mov ax, word[bp+4] ; readingn parameter
    mov cx, 10 ; dividing
    div cl
    push ax ; saving for later use

    mov ah, 0x07 ; changing background
    add al, 0x30 ; converting to number
    mov word[es:156], ax

    pop ax ; retoring ax
    mov al, ah
    mov ah, 0x07
    add al, 0x30
    mov word[es:158], ax

    popa
    pop bp
    ret 2

main:
    push 24
    call score

mov ax, 0x4c00
int 0x21