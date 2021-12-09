    ; printing all color combinations
    mov cx, 16
    mov di, 350
    mov ax, 0x00db
    loop1:
        stosw
        add ah, 1
        add di, 4
        loop loop1

