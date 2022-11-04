#!/bin/bash

filename="${1%%.*}" # remove .asm extension

echo
echo "[*] Compiling with NASM"
if [[ $file == *.asm ]]; then

	nasm -f elf32 -o ${filename}".o" ${filename}".asm"

else 
	nasm -f elf32 -o ${filename}".o" ${filename}".nasm"

fi

echo "[*] Linking"
ld -m elf_i386 ${filename}".o" -o ${filename}

echo "[*] Extracting opcodes"

echo "[*] Done"

echo
objdump -d ${filename} |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'


echo
echo "--------------------"
echo "[*] Hack the World!"
echo "--------------------"
echo



