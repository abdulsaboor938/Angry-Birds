[org 0x100]

; code to point es to video base 
mov ax, 0xb800
mov es,ax

; Code to print splash screen
splash:

; code to print bow on desired screen location
printbow:
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

main:
mov ax, 0x4c00
int 0x21