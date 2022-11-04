#!/bin/bash


ip=$1

first_octet=$(echo -n $ip | awk -F. '{print $1}')
second_octet=$(echo -n $ip | awk -F. '{print $2}')
third_octet=$(echo -n $ip | awk -F. '{print $3}')
fourth_octet=$(echo -n $ip | awk -F. '{print $4}')

byte_first_octet=$(echo "obase=16; $first_octet" | bc )
byte_second_octet=$(echo "obase=16; $second_octet" | bc )
byte_third_octet=$(echo "obase=16; $third_octet" | bc )
byte_fourth_octet=$(echo "obase=16; $fourth_octet" | bc )

printf "%02x\n" 0x"$byte_first_octet"
printf "%02x\n" 0x"$byte_second_octet"
printf "%02x\n" 0x"$byte_third_octet"
printf "%02x\n" 0x"$byte_fourth_octet"

