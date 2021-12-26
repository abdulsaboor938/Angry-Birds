[org 0x100]

; code to point es to video base 
mov ax, 0xb800
mov es,ax

jmp main

; Code to print splash screen
splash:

; code to print score
score:
    push bp
    mov bp, sp
    push ax
    push cx
    push dx

    mov ax, word[bp+4] ; moving the location to si
    mov ax, 0x0739
    mov word[es:156], ax
    mov word[es:158], ax

    pop dx
    pop cx
    pop ax
    pop bp
ret 2

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

;code to print dynamic cloud
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

;code to print a plank
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
    push 3650
    call plank
    push 3482
    call log
    push 3490
    call log
    push 3498
    call log
    push 3170
    call log
    push 2690
    call plank
    push 2690
    call log
    push 2206
    call triangle

;aliens
    mov ax, 0xba02
    mov word[es:2526],ax
    mov word[es:2522],ax
    mov word[es:2534],ax
    mov word[es:2538],ax

    mov word[es:3486],ax
    mov word[es:3166],ax

    mov word[es:3494],ax
    mov word[es:3174],ax

;print score
    push ax
    mov word[es:154], 0x0720
    mov ax, 0x0739
    mov word[es:156], ax
    mov word[es:158], ax
    pop ax

ret

loadbird:
pusha
;*****throw one (linear)******
 
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
	
;*****throw two ******

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

;*****throw three (parabola)******

    call delay
    call background
    push 2590
    call bird

    call delay
    call background
    push 1318
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
    push 2698
    call bird
; throw 4 5 dont hit the bricks
;*****throw four (stretch wider)******

    call delay
    call background
    push 2590
    call bird

    call delay
    call background
    push 0690
    call bird

    call delay
    call background
    push 0890
    call bird

    call delay
    call background
    push 0920
    call bird

    call delay
    call background
    push 1600
    call bird

;*****throw five (stretch slightly)******

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

main:
    mov cx, 4
    main_loop1:
        call loadbird
        loop main_loop1

mov ax, 0x4c00
int 0x21