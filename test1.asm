[org 0x100]

mov ax, 0xfd30
and ah, 0xf0
and ax, 0xffff
and ax, 0x0000

mov ax, 0x4c00
int 0x21