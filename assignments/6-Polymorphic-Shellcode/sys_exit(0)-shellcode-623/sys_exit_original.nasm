
global _start

section .text
_start:

xor eax, eax
mov al, 0x1
xor ebx, ebx
int 0x80

