[org 0x100]

jmp main

printbird:
    push bp
    mov bp, sp
    push ax
    push si

    mov si, word[bp+4]

    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0x03
    mov ah, 0x06
    mov al, 0x08
    mov word[es:si], ax

    pop si
    pop ax
    pop bp

ret 2

main:
    mov ax, 0xb800
    mov es, ax
    mov ax, 2540
    push ax
    call printbird

mov ax, 0x4c00
int 0x21