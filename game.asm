[org 0x100]

; code to point es to video base 
mov ax, 0xb800
mov es,ax

jmp main

; Code to print splash screen
splash:

; code to print score
    scoreprint:
        pusha

        mov ax, word[scorevar] ; reading parameter
        mov bl, 10 ; dividing
        div bl
        mov bx, ax

        mov ax, word[es:312]
        and ah, 0xf0
        mov al, bl
        add al, 0x30 ; converting to number
        mov word[es:312], ax

        mov ax, word[es:314]
        and ah, 0xf0
        mov al, bh
        add al, 0x30 ; converting to number
        mov word[es:314], ax

        popa
    ret

; code to throw bird
    throw1:
        pusha
        call delay
        call background
        push 2590
        call bird

        call delay
        call background
        push 2788
        call bird

        call delay
        call background
        push 2986
        call bird

        call delay
        call background
        push 3182
        call bird
    popa
    ret

    throw2:
        pusha
        call delay
        call background
        push 2590
        call bird

        call delay
        call background
        push 2294
        call bird
        
        call delay
        call background
        push 2496
        call bird

        call delay
        call background
        push 2698
        call bird
    popa
    ret

    throw3:
        pusha
        call delay
        call background
        push 2590
        call bird

        call delay
        call background
        push 1650
        call bird

        call delay
        call background
        push 1520
        call bird

        call delay
        call background
        push 1544
        call bird

        call delay
        call background
        push 1888
        call bird

        call delay
        call background
        push 2378
        call bird
    popa
    ret

    throw4:
        pusha
        call delay
        call background
        push 2590
        call bird

        call delay
        call background
        push 2758
        call bird

        call delay
        call background
        push 3266
        call bird
    popa
    ret

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

; code to print tree
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

; code to print dynamic cloud
    d_cloud:
        push bp
        mov bp, sp
        push ax
        push si

        mov si, word[bp+4] ; moving the location to si
        sub si,10
        mov ax, 0xbb08
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax


        sub si, 174
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
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
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax

        pop si
        pop ax
        pop bp
    ret 2

; code to print static cloud
    s_cloud:
        push bp
        mov bp, sp
        push ax
        push si

        mov si, word[bp+4] ; moving the location to si
        sub si,10
        mov ax, 0x310a
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax


        sub si, 176
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax

        sub si, 170
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax

        pop si
        pop ax
        pop bp
    ret 2
; code to print obstacles
    ; code to print level1 bottom
    obstacle13:
        pusha
        cmp word[levelvar3],13
        jnz end13


        mov word[es:3500], 0x6020
        mov word[es:3340], 0x6020
        mov word[es:3180], 0x6020
        mov word[es:3020], 0x6020

        mov word[es:3018], 0x6020
        mov word[es:3016], 0x6020
        mov word[es:3014], 0x6020
        mov word[es:3012], 0x6020
        mov word[es:3010], 0x6020

        mov word[es:3008], 0x6020
        mov word[es:3168], 0x6020
        mov word[es:3328], 0x6020
        mov word[es:3488], 0x6020

        mov word[es:3334], 0x3a02

        end13:
        popa
        ret

    ;code to print level1 middle
    obstacle12:
        pusha
        cmp word[levelvar2],12
        jnz end12

        mov word[es:2856], 0x6020
        mov word[es:2858], 0x6020
        mov word[es:2698], 0x6020

        mov word[es:2850], 0x6020
        mov word[es:2852], 0x6020
        mov word[es:2690], 0x6020

        mov word[es:2528], 0x6020
        mov word[es:2530], 0x6020
        mov word[es:2532], 0x6020
        mov word[es:2534], 0x6020
        mov word[es:2536], 0x6020
        mov word[es:2538], 0x6020
        mov word[es:2540], 0x6020

        mov word[es:2694], 0x3a02

        end12:
        popa
        ret

    ;code to print level1 top
    obstacle11:
        pusha
        cmp word[levelvar1],11
        jnz end11

        mov word[es:2374], 0x6020
        mov word[es:2214], 0x6020
        mov word[es:2054], 0x3a02

        mov word[es:2370], 0x3a02
        mov word[es:2378], 0x3a02

        end11:
        popa
        ret


; code to print a plank
    plank:
        push bp
        mov bp, sp
        push ax
        push si

        mov si, word[bp+4] ; moving the location to si
        sub si,8
        mov ax, 0x66db
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax
        add si, 2
        mov word[es:si], ax

        pop si
        pop ax
        pop bp
    ret 2

; code to print a log
    log:
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

        pop si
        pop ax
        pop bp
    ret 2

; code to print a triangle
    triangle:
        push bp
        mov bp, sp
        push ax
        push si

        mov ax, 0x6020
        mov si, word[bp+4] ; moving the location to si
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

        ; printing black bars
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
        pusha
        ; this code prints cyan color
        mov di, 0
        mov cx, 1760
        mov ax, 0x3320
        rep stosw

        ; prints brown color floor
        mov cx, 240
        mov ax, 0x2220
        rep stosw
        ; end of background

    ;tree
        push 3370
        call tree
        push 3408
        call tree
        push 3428
        call tree
        push 3440
        call tree
        push 3456
        call tree
    ;cloud
        push 1010
        call s_cloud
        push 1140
        call s_cloud
        push 1210
        call s_cloud

        push 1030
        call d_cloud
        push 1400
        call d_cloud

    ;bow
        push 3550
        call bow
    ;obstacle
        call obstacle13
        call obstacle12
        call obstacle11

    ;aliens
        ; mov ax, 0xba02
        ; mov word[es:2526],ax
        ; mov word[es:2522],ax
        ; mov word[es:2534],ax
        ; mov word[es:2538],ax

        ; mov word[es:3486],ax
        ; mov word[es:3166],ax

        ; mov word[es:3494],ax
        ; mov word[es:3174],ax

    ;print score
        call scoreprint
    popa
    ret

; code to load bird on bow
    loadbird:
        pusha
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
        popa    
    ret

main:
    mov cx, 4
    main_loop1:
        mov word[levelvar1], 11
        mov word[levelvar2], 12
        mov word[levelvar3], 13

        call loadbird
        call throw4
        call throw3
        mov word[levelvar1], 10
        call throw2
        mov word[levelvar2], 10
        call throw1
        mov word[levelvar3], 10
        inc word[scorevar]
        loop main_loop1

mov ax, 0x4c00
int 0x21

scorevar: dw 1

levelvar1: dw 11
levelvar2: dw 12
levelvar3: dw 13