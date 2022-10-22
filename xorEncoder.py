#!/usr/bin/python3

# Shellcode XOR, NOT byte Encoder

# TODO
#
#1- option to generate new key with the same instanced object using a random key;
#2- bad xor key byte - generate a key byte that is not present in the shellcode. this will result in a null byte and be the marker to stop the converting operation; 

import argparse
import secrets
import logging
import sys

#parser = argparse.ArgumentParser(description='[*] Miscellaneous Shellcode Encoder.')
#parser.add_argument('string', metavar='string', type=ascii, help='The string to be converted')

#args = parser.parse_args()

#logging.basicConfig(level=logging.DEBUG)
#logging.basicConfig(level=logging.INFO)

secretsGenerator = secrets.SystemRandom()

#c_style_shellcode = (b"\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x2f\x2f\x2f\x2f\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80") # bin/bash - execve stack technique shellcode -> execve(/bin/bash,/bin/bash,0)

c_style_shellcode = (b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80") # bin/sh

#c_style_shellcode = b"\x31\xc1"

def banner():

    print('''
        
        _______________________________________________________
         <The "XORCoder" - XOR your shellcode (encode/decode)>
        -------------------------------------------------------
            \   ^__^
            \   (oo)\_______
                (__)\       )\/\\
                    ||----w |
                    ||     ||       
        
         ''')

#----------------------------


class Encoder:

    def randomKeyGenerator(self):
        byte = '0x'
        for i in range(2):
            hexDigits = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f]
            nibble = secretsGenerator.choice(hexDigits) # it gets in decimal not hex format
            #print("nibble----"+hex(nibble)[2:])
            byte = byte + hex(nibble)[2:] # hex class is str type. Appending to 0x
        #print(byte)
        #chr(int(byte,16)) # converts from base 16 to integer (decimal) and then to ascii (chr func) 
        #print(int(byte,16))
        return int(byte,16) # convert key to bytes and return


    def __init__(self,enc_type, key=None):
        if enc_type != "not":
            
            if key is not None:
                self.key = key
                print("[*] Key Provided. Doing magic with it")
            else:
                self.key = self.randomKeyGenerator()
                print("[*] Doing magic with a (pseudo) Random key")
            print("[*] Key: "+hex(self.key))
   
    
    # xor encoding in \x format (\x56\xbd\xca,...)
    def xor_encoding_backslashX(self,shellcode):
        logging.debug(shellcode)
        encoded = ''
        
        for shellbyte in shellcode:
            #logging.info("Shellbyte type - "+str(shellbyte))
            #logging.info("key type - "+str(self.key))
            encoded_byte = shellbyte ^ self.key # xor operation
            #logging.info("encode byte: "+str(encoded_byte))

            encoded += '\\x' + hex(encoded_byte)[2:]

        print("\n[*] \\x format: ")
        print(encoded)


    # xor encoding in 0x output format (thex56,0xbd,0xca,...)
    def xor_encoding_0x(self,shellcode):
        logging.debug(shellcode)
        encoded = ''

        for shellbyte in shellcode:
            logging.info("Shellbyte type - "+str(shellbyte))
            #logging.info("key type - "+str(self.key))
            encoded_byte = shellbyte ^ self.key # xor operation
            #logging.info("encode byte: "+str(encoded_byte))
            encoded += '0x'+ hex(encoded_byte)[2:] + ','
            
        print("\n[*] 0x format: ")
        print(encoded[:-1])


    # two's complement is the inverse representation of a NOT operation
    def complement_encoding(self, shellcode): 
        encoded = '' # 0x format
        encoded2 = '' # \x format

        for shellbyte in shellcode:
            logging.info("Shellbyte type - "+str(shellbyte))
            encoded_byte = ~shellbyte  # not bitwise operation
            encoded += hex(encoded_byte & 0xff) + ','

            encoded2 += '\\x' + hex(encoded_byte & 0xff)[2:] # \x format

        print("\n[*] \\x format: ")
        print(encoded2)
            
        print("\n[*] 0x format: ")
        print(encoded[:-1])
    
    def insertion_encode(self, shellcode):

        encoded = '' # 0x format
        encoded2 = '' # \x format

        for shellbyte in shellcode:
            logging.info("Shellbyte type - "+str(shellbyte))
            encoded += hex(shellbyte) + ',' + hex(self.key)  + ','


            encoded2 += '\\x' + hex(shellbyte)[2:] + '\\x' + hex(self.key)[2:] # \x format

        print("\n[*] \\x format: ")
        print(encoded2)
            
        print("\n[*] 0x format: ")
        print(encoded[:-1])



def main():
   
    shellcode = bytearray(c_style_shellcode)
    print("[*] Shellcode length: "+str(len(shellcode))+"\n")
    print("[*] Shellcode: "+str(c_style_shellcode)+"\n")



    # -------------------KEY-------------- 
    key = 0xaa
    #key = None
    #####################################

    # -------------Encode Type-----------
    enc_type = "xor"
    #####################################




    #if key is not None:
     #   key = bytes.fromhex(key)
      #  logging.debug(key)
    
    if enc_type == "not":

        encoder = Encoder(enc_type)
        encoder.complement_encoding(shellcode)

    elif enc_type == "xor":
    
        encoder = Encoder(enc_type, key)
        encoder.xor_encoding_backslashX(shellcode)# utf-8 encoding (\x4b,\xe4,...)
        encoder.xor_encoding_0x(shellcode) # hex format (0x4b, 0xe4,...)
    
    elif enc_type == "insertion":
        encoder = Encoder(enc_type, key)
        encoder.insertion_encode(shellcode)
           
    else:
        print("[*] Encode type not supported. Please check the supported algorithms in the help menu")
        #sys.exit()






if __name__ == '__main__':

    banner() # displays the program banner
    main()
    print("\n--------------------")
    print("[*] Hack the World!")
    print("--------------------")
    print()
    print()

