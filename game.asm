[org 0x100]

; code to point es to video base 
mov ax, 0xb800
mov es,ax

jmp main

; Code to print splash screen
splash:

; code to add delay to code
delay:
    push cx
    mov cx, 20
    delay_loop_1:
        push cx
        mov cx, 0xffff
        delay_loop_2:
        loop delay_loop_2
        pop cx
        loop delay_loop_1
    pop cx
ret

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
    or ah, 0xe
    mov al, 0xdb
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xe
    mov al, 0xdb
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0x00
    mov al, 0x1a
    mov word[es:si], ax

    add si, 8
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xe
    mov al, 0xdb
    mov word[es:si], ax

    add si, 2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0x4
    mov al, 0x10
    mov word[es:si], ax

    sub si, 162
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xe
    mov al, 0xdc
    mov word[es:si], ax

    sub si,2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xe
    mov al, 0x0a
    mov word[es:si], ax

    sub si, 2
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0xe
    mov al, 0xdc
    mov word[es:si], ax

    sub si, 158
    mov ax, word[es:si]
    and ah, 0xf0
    or ah, 0x00
    mov al, 0xc2
    mov word[es:si], ax

    pop si
    pop ax
    pop bp

ret 2

;code to print tree
tree:
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
    
    mov ax, 0x2020
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
    sub si, 166
    mov word[es:si], ax
    add si, 2
    mov word[es:si], ax
    add si, 2
    mov word[es:si], ax
    sub si, 162
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
    mov di, 0
    mov cx, 1760
    mov ax, 0x3320
    rep stosw
    mov cx, 240
    mov ax, 0x2220
    rep stosw

    push 3404
    call tree
    push 3424
    call tree
    push 3440
    call tree
    push 3450
    call tree
    push 3370
    call tree

    push 3550
    call bow

ret

loadbird:
    call delay
    call background
    push 3214
    call bird

    call delay
    call background
    push 3058
    call bird

    call delay
    call background
    push 2902
    call bird

    call delay
    call background
    push 2746
    call bird

    call delay
    call background
    push 2590
    call bird

    call delay
    call background
    push 2756
    call bird

ret

main:
    mov cx, 4
    main_loop1:
        call loadbird
        loop main_loop1

mov ax, 0x4c00
int 0x21