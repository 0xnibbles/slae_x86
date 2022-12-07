
global _start

section .text
_start:

xor eax, eax
push byte 1
pop ebx
xchg eax, ebx
syscall

; Shellcode size: 8