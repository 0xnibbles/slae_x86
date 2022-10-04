#!/bin/bash

filename="${1%%.*}" # remove .asm extension

echo "[*] Compiling"
nasm -f elf32 -o ${filename}".o" ${filename}".asm"

echo "[*] Linking"
ld -m elf_i386 ${filename}".o" -o ${filename}
echo "[*] Done"

echo
echo "--------------------"
echo "[*] Hack the World!"
echo "--------------------"
echo

