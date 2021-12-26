[org 0x100]

mov ax, 0xb800
mov es, ax

jmp main

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

main:
    call obstacle13
    call obstacle12
    call obstacle11

    mov ax, 0x4c00
    int 0x21

levelvar1: dw 10
levelvar2: dw 12
levelvar3: dw 10