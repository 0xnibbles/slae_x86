; Author: Eduardo Silva
; Execve JMP-CALL-POP Technique
;
;Execute /bin/bash using eexecve syscall
;eax, ebx, ecx and edx are used as arguments to execve (man execve)
;esi is used to stored the address of /bin/bash string
; esi is also used to prepare the syscalls args and move them to ebx,ecx and edx registers
;




global _start

section .text

_start:

	jmp call_shellcode

shellcode:

	pop esi
	xor ebx, ebx
	mov [esi+9], bl	
	mov dword [esi+10], esi
	mov dword [esi+14], ebx ; ebx is already zero
	
	lea ebx, [esi] 	  ;/bin/bash, 0x0
	lea ecx, [esi+10] ;argv --> esi address
	lea edx, [esi+14] ;envp --> null bytes (0x0000)
	xor eax, eax
	mov al, 0xb 	  ; mov to al isntead eax to avoid null bytes in the shellcode 
	int 0x80 	  ; execve is the syscall number 11 (0xb)

	;execve does not need an exit function because does not return on sucess, an the text, data,
	; bss, and the stack are overwritten by that of the program loaded.
	; and executing the bash binary already has exit function setup


call_shellcode:

	call shellcode
	message db "/bin/bashABBBBCCCC"



