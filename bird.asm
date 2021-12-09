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
    or ah, 0xf
    mov al, 0xdb
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0xdb
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0xdb
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0x07
    or ah, 0x00
    mov al, 0x1a
    mov word[es:si], ax

    add si, 8
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0xdb
    mov word[es:si], ax

    add si, 2
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0xdf
    mov word[es:si], ax

; first floor

    sub si, 162
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0xdc
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0x0a
    mov word[es:si], ax

    sub si, 2
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0xdc
    mov word[es:si], ax

; second floor

    sub si, 158
    mov ax, word[es:si]
    and ah, 0x0e
    or ah, 0xc
    mov al, 0xc2
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