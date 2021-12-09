[org 0x100]

; code to point es to video base 
mov ax, 0xb800
mov es,ax

jmp main

; Code to print splash screen
splash:

; code to print bird on screen
bird:
    push bp
    mov bp, sp
    push ax
    push si

    mov si, word[bp+4]

    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xf
    mov al, 0xdb
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xc
    mov al, 0xdb
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0xf0
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
    and ah, 0xf0
    or ah, 0xc
    mov al, 0xdb
    mov word[es:si], ax

    add si, 2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xc
    mov al, 0xdf
    mov word[es:si], ax

; first floor

    sub si, 162
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xc
    mov al, 0xdc
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xc
    mov al, 0x0a
    mov word[es:si], ax

    sub si, 2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xc
    mov al, 0xdc
    mov word[es:si], ax

; second floor

    sub si, 158
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xc
    mov al, 0xc2
    mov word[es:si], ax

    pop si
    pop ax
    pop bp

ret 2


; code to print bow on desired screen location
bow:
    push bp
    mov bp, sp
    push ax
    push si

    mov ax, 0x6020

    mov si, word[bp+4] ; moving the location to si
    mov word[es:si], ax ; base character
    sub si, 160
    mov word[es:si], ax
    sub si, 160
    mov word[es:si], ax
    sub si, 164
    mov word[es:si], ax
    add si, 2
    mov word[es:si], ax
    add si, 2
    mov word[es:si], ax
    add si, 2
    mov word[es:si], ax
    add si, 2
    mov word[es:si], ax
    sub si, 168
    mov word[es:si], ax
    add si, 8
    mov word[es:si], ax
    mov ax, 0x60dc
    sub si, 168
    mov word[es:si], ax
    add si, 8
    mov word[es:si], ax

    pop si
    pop ax
    pop bp
ret 2

; Code block to print background
background:
    mov si, 0
    mov cx, 1761
    mov ax, 0x3320
    rep stosw
    mov cx, 240
    mov ax, 0x2220
    rep stosw

    push 3550
    call bow

    push 3214
    call bird

ret
main:
    call background
mov ax, 0x4c00
int 0x21