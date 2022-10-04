
global _start

section .text:
_start:

	mov ecx, 0x3

print:

	push ecx
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, message
	mov edx, mlen
	int 0x80

	pop ecx
	loopnz print


	; sys_exit syscall
	mov eax, 0x1
	mov ebx, 0x0
	int 0x80



section .data:

	message: db "Hello World! "
	mlen equ $ - message





