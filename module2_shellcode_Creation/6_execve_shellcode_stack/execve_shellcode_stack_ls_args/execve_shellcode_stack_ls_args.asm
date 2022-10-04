; Author: Eduardo Silva
; Execve JMP-CALL-POP Technique
;
;Execute /bin/ls -la using execve syscall
;eax, ebx, ecx and edx are used as arguments to execve (man execve)
;




global _start

section .text

_start:
		

	; push the null dword to the top of the stack
	xor eax, eax
	push eax
	push 0x68616c2d ;-lah
	mov esi, esp	

	
	push eax
	; push /bin//ls
	push 0x736c2f2f ;//ls
	push 0x6e69622f	;/bin

	mov ebx, esp
	
	;push null and mov it to edx (envp)
	push eax
	mov edx, esp
	;cdq ; put 0 into edx using the signed bit from eax (how to work??how to work????)

	; push address of /bin//ls -lah
	;push eax
	push esi 
	push ebx
	mov ecx, esp

	;call execve syscall
	mov al, 0xb
	int 0x80	


