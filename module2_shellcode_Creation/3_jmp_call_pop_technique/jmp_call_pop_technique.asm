; Author: Eduardo Silva
; jmp_call_pop_technique.asm


global _start

section .text
_start:

	jmp call_shellcode

shellcode:

	; write syscall
	xor eax, eax
	mov al, 0x4

	xor ebx, ebx
	mov bl, 0x1

	;mov ecx, message
	pop ecx

	xor edx, edx
	mov dl, 13
	
	int 0x80 ; call interruption 0x80 (syscall)

	
	; exit syscall
	xor eax, eax
	mov al, 0x1
	xor ebx, ebx
	mov bl, 0x5
	int 0x80
	
call_shellcode:

	call shellcode  ; call instruction will push to the stach the next instruction address (message address)
	message: db "Hello World!", 0xA

