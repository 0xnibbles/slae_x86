
global _start

section .text
_start:

xor ebx, ebx
mul ebx
inc eax
syscall

; 7 bytes size

