#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc0\xb0\x01\x31\xdb\xb3\x05\xcd\x80";


main()
{

	printf("Shellcode Length; %d\n", strlen(code));
	int (*ret)() = (int(*)())code;

	ret();

}

