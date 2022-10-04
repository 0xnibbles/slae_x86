; Author: Eduardo Silva
; jmp_call_pop_technique.asm


global _start

section .text
_start:


	; write syscall
	xor eax, eax
	mov al, 0x4

	xor ebx, ebx
	mov bl, 0x1

	xor edx, edx
	push  edx ; zeroes top of the stack (esp) because string needs 2be null terminated
		  ; "Hello World\n0x00"

	push 0x0a73646c
	push 0x726f5720
	push 0x6f6c6c65
	push 0x48656565
	


	lea ecx, [esp+3] ; address reference of the string to ecx

	mov dl, 13
	
	int 0x80 ; call interruption 0x80 (syscall)

	
	; exit syscall
	xor eax, eax
	mov al, 0x1
	xor ebx, ebx
	mov bl, 0x5
	int 0x80
	
