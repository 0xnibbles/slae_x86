; Author: Eduardo Silva
; Execve JMP-CALL-POP Technique
;
;Execute /bin/bash using eexecve syscall
;eax, ebx, ecx and edx are used as arguments to execve (man execve)
;top of the stack (esp) is used to stored the address of /bin/bash string
;




global _start

section .text

_start:

	; push the first null dword
	xor eax, eax
	push eax

	; push /bin////bash
	push 0x68736162
	push 0x2f2f2f2f
	push 0x6e69622f

	mov ebx, esp
	
	;push null and mov it to ebx (envp)
	push eax
	mov edx, esp

	; push address of /bin///bash (ebx) to ecx 
	push ebx
	mov ecx, esp

	;call execve syscall
	mov al, 0xb
	int 0x80	


