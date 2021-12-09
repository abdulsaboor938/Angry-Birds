[org 0x100]
jmp main
loading: db 'Loading...  ', 0
game: db 'ANGRY BIRDS', 0
score: db 'SCORE: 00', 0

; ANAS' CODE
clrscr:		
	push es
	push ax
	push di
	
	mov ax, 0xb800
	mov es, ax ; point es to video base
	mov di, 0 ; point di to top left column
	nextloc: 
		mov word [es:di], 0x0720 ; clear next char on screen
		add di, 2 ; move to next screen location
		cmp di, 4000 ; has the whole screen cleared
		jne nextloc ; if no clear next position
	pop di
	pop ax
	pop es
	ret 
	

drawBow:
	push bp
	mov bp, sp
	push ax

	

	mov ax, 0xE020; character
	push ax
	mov ax, 18; top
	push ax
	mov ax, 21; bottom
	push ax
	mov ax, 8; left
	push ax
	call drawVertical
	
	mov ax, 0xE020; character
	push ax
	mov ax, 18; top
	push ax
	mov ax, 6; left
	push ax
	mov ax, 11 ;right
	push ax
	call drawHorizontal

	mov ax, 0xE020; character
	push ax
	mov ax, 16; top
	push ax
	mov ax, 18; bottom
	push ax
	mov ax, 6; left
	push ax
	call drawVertical

	mov ax, 0xE020; character
	push ax
	mov ax, 16; top
	push ax
	mov ax, 18; bottom
	push ax
	mov ax, 10; left
	push ax
	call drawVertical

	pop ax
	pop bp
	ret 


drawdiamond:	
	;subroutine to draw diamond on screen
				push bp		;stack order: x [bp+4], y [bp+6]
				mov bp, sp
				push es
				push di
				push ax
				push cx
	mov ax, 0xb800
	mov es, ax
	mov al, 80
	mul byte [bp+6]
	add ax, [bp+4]
	shl ax, 1
	mov di, ax
	
	mov ax, 0x3F2A	;white asterisk on aqua background
	mov cx, 3
	rep stosw		;stosw-> mov [es:di], ax		rep-> repeats cx times
	
	add di, 156
	mov [es:di], ax
				
				pop cx
				pop ax
				pop di
				pop es
				pop bp
				ret 4	;x, y

drawVertical:
	push bp
	mov bp, sp
	push ax
	push cx
	push es
	push di

	
	push 0xb800
	pop es
	
	;finding the location
	mov al, 80
	mul byte[bp + 8]; top
	add ax, [bp + 4]; left/right
	shl ax, 1
	mov di, ax
	
	;loop count
	mov cx, [bp + 6]; bottom
	sub cx, [bp + 8]; top
	
	mov ax, [bp + 10]; character
	
	loop4:
		call delay
		mov [es:di], ax
		add di, 160
		loop loop4
		
	pop di
	pop es
	pop cx
	pop ax
	pop bp
	
	ret 8
	
drawHorizontal:
	push bp
	mov bp, sp
	push ax
	push cx
	push es
	push di

	
	push 0xb800
	pop es
	
	;finding the location
	mov al, 80
	mul byte[bp + 8]
	add ax, [bp + 6]
	shl ax, 1
	mov di, ax
	
	;loop count
	mov cx, [bp + 4]; right
	sub cx, [bp + 6]; left
	
	mov ax, [bp + 10]; character
	
	loop2:
		mov [es:di], ax
		add di, 2
		loop loop2
		
	pop di
	pop es
	pop cx
	pop ax
	pop bp
	
	ret 8

PrintRectangle:
	push bp
	mov bp, sp
	push ax
	push cx
	push di
	push es
	
	;top line
		mov ax, [bp+12]; character
		push ax
		mov ax, [bp+10]; top
		push ax
		mov ax, [bp+6]; left
		push ax
		mov ax, [bp+4]; right
		push ax
		call drawHorizontal
		
		;left line
		mov ax, [bp+12]; character
		push ax
		mov ax, [bp+10]; top
		push ax
		mov ax, [bp+8]; bottom
		push ax
		mov ax, [bp+6]; left
		push ax
		call drawVertical
		
		;right line
		mov ax, [bp+12]; character
		push ax
		mov ax, [bp+10]; top
		push ax
		mov ax, [bp+8]; bottom
		push ax
		mov ax, [bp+4]; right
		sub ax, 1		;adjustment of right coordinate
		push ax
		call drawVertical
		
		;bottom line
		mov ax, [bp+12]; character
		push ax
		mov ax, [bp+8]; bottom
		sub ax, 1		;adjustment of bottom coordinate
		push ax
		mov ax, [bp+6]; left
		push ax
		mov ax, [bp+4]; right
		push ax
		call drawHorizontal
	
						pop es
						pop di
						pop cx
						pop ax
						pop bp
						ret 10	;right, left, bottom, top, character with attribute
		
		
delay:
	push cx
	mov cx, 3 ; change the values  to increase delay time
	delay_loop1:
		push cx
		mov cx, 0xFFFF
	delay_loop2:
		loop delay_loop2
		pop cx
		loop delay_loop1
		pop cx
	ret


position:
	; y = [bp + 4], x = [bp + 6]
	push bp
	mov bp, sp
	push ax
	
	mov al, 80
	mul word[bp + 4]; 80*y
	add ax, [bp + 6]; 80* y + x
	shl ax, 1; (80* y + x)*2
	mov di, ax
	
	pop ax
	pop bp
	
	ret 4

strlen:
	push bp
	mov bp, sp
	push cx
	push es
	push di
	
	les di, [bp + 4]
	xor al, al
	mov cx, 0xffff
	repne scasb 
	mov ax, 0xffff
	sub ax, cx
	dec ax
	
	pop di
	pop es
	pop cx
	pop bp
	
	ret 4
						
printstr:
			;subroutine to print string on screen
			; y = [bp + 4], x = [bp + 6], string = [bp + 8], attribute = [bp + 11]
            push bp
			mov bp, sp
            push ax
            push cx
            push es
            push di
            push si
			

    push 0xB800
	pop es
	
	push ds; data segment
	push word[bp + 8]; string
	call strlen
    cmp ax, 0
    je exit

    mov cx, ax
	mov ax, 0

	push word[bp+6]; x
    push word[bp+4]; y
    call position

    mov ah, [bp + 11]
	mov si, [bp+8]
	
	cld
	nextchar:
		lodsb 
		stosw
		loop nextchar
	
	
	exit:
		pop si
        pop di
        pop es 
		pop cx
		pop ax
		pop bp
	
	ret 8

printnum:	
		;subroutine to print number passed as parameter from main
		push bp
		mov bp, sp
		push es
		push ax
		push bx
		push cx
		push dx
		push di
		
		push word[bp+6]; x
		push word[bp+4]; y
        call position
		
		mov ax, 0xb80A
		mov es, ax
		mov ax, [bp+8]; number
		mov bx, 10	;use base 10 for division
		mov cx, 0	;initialize count for digits

	nextdigit:	
			mov dx, 0
			div bx
			add dl, 0x30	;+48 to convert into ascii
			push dx
			inc cx
			cmp ax, 0
			jnz nextdigit

	nextpos:	
			pop dx
			mov dh, 0x60
			mov [es:di], dx
			add di, 2
			loop nextpos

		pop di
		pop dx
		pop cx
		pop bx
		pop ax
		pop es
		pop bp
		ret 6



PrintCloud:
	;right 		bp + 4
	;left 		bp + 6
	;bottom 	bp + 8
	;top		bp + 10
	;character  bp + 12
	push bp
	mov bp, sp
	push ax
	push cx
	push di
	push es
	
	;base line
		mov ax, [bp+12]; character
		push ax
		mov ax, [bp+10]; top
		push ax
		mov ax, [bp+6]; left
		push ax
		mov ax, [bp+4]; right
		push ax
		call drawHorizontal
	;mid line
		mov ax, [bp + 12]
		push ax
		mov ax,[bp + 10]
		dec ax
		push ax
		mov ax, [bp + 6]
		add ax, 2
		push ax
		mov ax, [bp + 4]
		sub ax, 2
		push ax
		call drawHorizontal
	;top line
		mov ax, [bp + 12]
		push ax
		mov ax,[bp + 10]
		sub ax, 2
		push ax
		mov ax, [bp + 6]
		add ax, 5
		push ax
		mov ax, [bp + 4]
		sub ax, 5
		push ax
		call drawHorizontal
	
	pop es
	pop di
	pop cx
	pop ax
	pop bp

	ret 10

drawBird:
	push bp
	mov bp, sp
	push es
	push di
	push ax
	push bx
	push cx
	mov ax, 0xb800
	mov es, ax
	mov di, [bp + 4]
	mov cx, 5
	mov bx, 0

	mov word [es:di - 2], 0x3420 ;hair

	l1:                                   ;body loop
		mov word [es:di + bx], 0x4420 
		mov word [es:di + bx + 160], 0x4420 
		mov word [es:di + bx + 320], 0x4420 
		mov word [es:di + bx + 480], 0x6420
		add bx, 2
		loop l1

	mov word [es:di + 4 + 160], 0x876f ;eye

	mov word [es:di + 10 + 160], 0xEE00 ;beak
	mov word [es:di + 12 + 160], 0xEE00

	pop cx
	pop bx
	pop ax
	pop di
	pop es
	pop bp
	ret 2
; MANSOOR'S CODE
setBackground: 
    push es 
    push ax 
    push cx 
    push di

    mov ax, 0xb800
    mov es, ax 
    xor di, di 
    mov ax, 0x3020    ;sky blue colour
    mov cx, 1600

    cld
    
    rep stosw

    mov cx,400
    mov ax,0x2a1c
    
    rep stosw

    pop di 
    pop cx 
    pop ax 
    pop es 
    
    ret
 
tree:

	;storing values of registers and segements on the stacks
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push di
	push si
	push es
	
	mov ax, 0xb800  ; accessing video memory
	mov es, ax      ;ponting es towards video memory
	mov al, 80      ; load al with columns per row 
	mul byte [bp+6] ; multiply with y position
	add ax, [bp+8]  ; add x position
	mov cx,[bp+4]   ;moving height of tree in cx
	shl ax, 1        
	mov di,ax 
	
	mov bx,2
	mov dx,bx
	mov ax,0xa12a   ; ascii of * is 2a  and attribute green background with white foreground
	mov [es:di],ax
	dec cx
	
	loop1 :
		add ah,2
		add di,158
		push di
		mov [es:di],ax
 
	a:
		add di,2
		mov [es:di],ax
		dec bx
		cmp bx,0
		jne a
		pop di
		mov bx,dx
		add bx,2
		mov dx,bx
		loop loop1
		
		mov cx,[bp+4]
		dec cx
	b: 
		add di,162
		loop b
		
		mov [es:di],ax
		push di
		mov bx,2
		mov dx,bx
		
		mov cx,[bp+4]
		dec cx
		dec cx
	loop_2 :
		add ah,2
		sub di,162
		push di
		mov [es:di],ax
 
	c:
		add di,2
		mov [es:di],ax
		dec bx
		cmp bx,0
		jne c
		pop di
		mov bx,dx
		add bx,2
		mov dx,bx
		loop loop_2
		pop di
		mov ax,0x6720     ;ascii of space is 20 ans 67 is attribute for brown colour
		mov cx,[bp+4]
	d:
		add di,160
		mov [es:di],ax

		dec cx
		cmp cx,0
		jne d
	;restoring previous values 
	pop es
	pop si
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp

	;emptying the stack
	ret 6

tree2:
    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
 
    mov ax, 0xb800  ; accessing video memory
    mov es, ax      ;ponting es towards video memory
    mov al, 80      ; load al with columns per row 
    mul byte [bp+6] ; multiply with y position
    add ax, [bp+8]  ; add x position
    mov cx,[bp+4]   ;moving height of tree in cx
    shl ax, 1        
    mov di,ax 
 
    push di
    mov ax,0xa12a     ; ascii of * is 2a  and attribute green background with white foreground
    
    ;printing left portion of tree
    ; e.g
    ;   *
    ;  *
    ; *
    mov [es:di],ax
    dec cx
    
    t2loop: 
        add di,158
        mov [es:di],ax
        loop t2loop


    ;printing base of the tree
    ;e.g

    ;***
    
    add ah,3
    mov cx,[bp+4]
    shl cx,1
    add cx,1

    add di,158 ; moving to next line
    
    mov [es:di],ax
    dec cx
 
    t2loop2:
        add di,2    
        mov [es:di],ax
        loop t2loop2
 
    mov cx,[bp+4]
    shl cx,1
    sub di, cx   ;going to the middle point of the tree to print trunk
    
    ;now printing trunk
    mov cx,[bp+4]
    mov ax,0x6409     ;ascii of space is 20 ans 67 is attribute for brown colour
    
    t2loop4:
        add di,160
        mov [es:di],ax
        loop t2loop4
 
    pop di     ;popping top point of the tree to go to the position from where the tree has started
    
    ;print right side of tree
    ;e.g
    ;*
    ; *
    ;  *
    mov cx,[bp+4]
    dec cx

    mov ax,0xa82a
 
    t2loop3:
        add di,162
        mov [es:di],ax
        loop t2loop3
 
    ;restoring previous values 
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp

    ;emptying the stack
    ret 6
 
tree3:

    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push es
 
    mov ax, 0xb800  ; accessing video memory
    mov es, ax      ;ponting es towards video memory
    mov al, 80      ; load al with columns per row 
    mul byte [bp+6] ; multiply with y position
    add ax, [bp+8]  ; add x position
    mov cx,[bp+4]   ;moving height of tree in cx
    push cx
    mov bx,cx
    push bx
    shl ax, 1        
    mov di,ax 
    
    mov ax,0xa42a     ; ascii of * is 2a  and attribute green background with white foreground
    mov [es:di],ax
    
    add ah,1
    push di
 
    t3loop:

        add di,158
        push di
    
    t3loop1:
        mov [es:di],ax
        add di,2
        loop t3loop1     

    mov bx,[bp-18]   
    dec bx     ;decrementing height of tree
    mov [bp-18],bx    
    
    mov cx,[bp+4]
    add cx,2
    mov [bp+4],cx
    pop di
    add ah,1
    cmp bx,0
    jne t3loop
 

    mov cx,[bp+4]
    shr cx,1
    add di,cx
    add di,2

    ;now printing trunk
    mov cx,[bp-16]
    
    mov ax,0x6720     ;ascii of space is 20 ans 67 is attribute for brown colour
 
 
hello:
    add di,160
    mov [es:di],ax

    dec cx
    cmp cx,0
    jne hello
 
    add sp,6
    pop es
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    
    ret 6



; SANA'S CODE
print1:
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, dx ;

next1:
mov word [es:di], 0x4420        
add di, 2                                               ; move to next screen location
cmp di, si                                    ; has the whole screen cleared
jne next1                                           ; if no clear next position
pop di
pop ax
pop es
ret

print2:
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, dx ;

next2:
mov word [es:di], 0x6720   
mov word [es:di+2], 0x6720   
mov word [es:di-160], 0x6720  
mov word [es:di-160+2], 0x6720  

pop di
pop ax
pop es
ret

print3:
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, dx ;

next3:
mov word [es:di], 0x6720
mov word [es:di+2], 0x6720
add di, 160   
cmp di, 4000 
jle next3                                           ; has the whole screen cleared  

pop di
pop ax
pop es
ret

print4:
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, dx ;

next4:
mov word [es:di], 0x6720
mov word [es:di-160], 0x6720
mov word [es:di+2], 0x6720
mov word [es:di+4], 0x6720
jle next4                                           ; has the whole screen cleared  

pop di
pop ax
pop es
ret

print5:
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, dx ;

next5:
mov word [es:di], 0x6720
mov word [es:di+320+2], 0x6720
mov word [es:di+320+4], 0x6720
mov word [es:di-160], 0x6720
mov word [es:di-2], 0x6720
mov word [es:di-4], 0x6720
jle next5                                           ; has the whole screen cleared  

pop di
pop ax
pop es
ret


print6:
push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, dx ;

next6:
mov word [es:di+2], 0x2020
mov word [es:di-4], 0x2020
mov word [es:di], 0x7020
mov word [es:di-160], 0x2020
mov word [es:di-8], 0x7020
mov word [es:di-10], 0x2020
mov word [es:di+160], 0x2020
mov word [es:di+160-8], 0x2020
mov word [es:di+160-2], 0x2020
mov word [es:di+160-4], 0x2020
mov word [es:di+160-6], 0x2020

mov word [es:di+320-2], 0x2020
mov word [es:di+320-6], 0x2020
mov word [es:di+320-4], 0x2020

mov word [es:di-320-4], 0x2020

mov word [es:di-160-2], 0x2020
mov word [es:di-160-4], 0x4420
mov word [es:di-160-6], 0x2020
mov word [es:di-160-8], 0x2020
mov word [es:di-320], 0x1820
mov word [es:di-320+2], 0x1820



pop di
pop ax
pop es
ret






main:

	call clrscr
	call setBackground 
    
	mov dx, 2994
	push dx
	mov si, 3016
	push si
	call print1

	mov dx, 2348 
	push dx
	mov si, 2382
	push si
	call print1

	mov dx, 1220
	push dx
	mov si, 1270
	push si
	call print1

	mov dx, 2190 
	push dx
	call print2

	mov dx, 1870 
	push dx
	call print2

	mov dx, 1710 
	push dx
	call print2

	mov dx, 2216
	push dx
	call print2

	mov dx, 1896
	push dx
	call print2

	mov dx, 1736
	push dx
	call print2

	mov dx, 1070
	push dx
	call print2

	mov dx, 910
	push dx
	call print2

	mov dx, 936
	push dx
	call print2

	mov dx, 1096
	push dx
	call print2

	mov dx, 3150
	push dx
	call print3

	mov dx, 3176
	push dx
	call print3

	mov dx, 2834
	push dx
	call print4

	mov dx, 2854
	push dx
	call print5

	mov dx, 1730
	call print6
	mov dx, 610
	call print6


    push 35   ;x position
    push 14   ;y position
    push 3   ;height of tree
    call tree3

    push 20
    push 13
    push 3
    call tree2
    
    push 45
    push 13
    push 3
    call tree

	call drawBow


	;	PRINTING 5 CLOUDS OF DIFFERENT SIZES
	mov ax, 0x992A
	push ax
	push 3; top
	push 5; bottom
	push 2; left
	push 15; right
	call PrintCloud

	mov ax, 0x992A
	push ax
	push 5; top
	push 10; bottom
	push 17; left
	push 32; right
	call PrintCloud

	mov ax, 0x992A
	push ax
	push 3; top
	push 5; bottom
	push 33; left
	push 45; right
	call PrintCloud

	; mov ax, 0x992A
	; push ax
	; push 5; top
	; push 10; bottom
	; push 46; left
	; push 60; right
	; call PrintCloud

	; mov ax, 0x992A
	; push ax
	; push 3; top
	; push 10; bottom
	; push 61; left
	; push 73; right
	; call PrintCloud

	push 0x0220			;green on black
	push score		;"SCORE"
	push 71			;x
	push 0			;y							
	call printstr


	push 2092
	call drawBird

	;call delay
	;call clrscr
	
	; mov ax, 0x3020
	; push ax
	; push 5; top
	; push 25; bottom
	; push 15; left
	; push 55; right
	; call PrintRectangle
	
	; call delay
	; call clrscr
	
	
	; mov ax, 0xE020  ;attribute +11
	; push ax
	; mov ax, loading ;string +8
	; push ax
	; mov ax, 35		;x coordinate +6
	; push ax
    ; mov ax, 9		;y coordinate +4
	; push ax
	; call printstr
	
	; mov cx, 101
	; mov bx, 0
	; prnt:
	; 	push bx
    ;     mov ax, 45; x
	; 	push ax
	; 	mov ax, 8; y
	; 	push ax
	; 	call printnum
	; 	call delay
	; 	add bx, 1
	; 	loop prnt
		
	
	; call delay
	; ;call clrscr
	
	; mov ax, 0x6020
	; push ax
	; mov ax, game
	; push ax
	; mov ax, 35		;x coordinate
	; push ax
    ; mov ax, 9		;y coordinate
	; push ax
	; call printstr

	; call delay
	; ;call clrscr	


	
	; push 14										;diamond on left long row
	; push 29
	; call drawdiamond


	; mov ax, 0xE020
	; push ax
	; push 10; top
	; push 15; bottom
	; push 25; left
	; push 45; right
	; call PrintRectangle
	

	
	mov ax, 0x4c00
	int 21h
	