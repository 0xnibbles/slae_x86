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

	push 0x0a646c72
	push 0x6f57206f
	push 0x6c6c6548

	mov ecx, esp ; reference of the string to ecx

	mov dl, 12
	
	int 0x80 ; call interruption 0x80 (syscall)

	
	; exit syscall
	xor eax, eax
	mov al, 0x1
	xor ebx, ebx
	mov bl, 0x5
	int 0x80
	
