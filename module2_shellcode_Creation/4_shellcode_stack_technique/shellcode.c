#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x31\xd2\x52\x68\x6c\x64\x73\x0a\x68\x20\x57\x6f\x72\x68\x65\x6c\x6c\x6f\x68\x65\x65\x65\x48\x8d\x4c\x24\x03\xb2\x0d\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xb3\x05\xcd\x80";

main()
{

	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;

	ret();

}


