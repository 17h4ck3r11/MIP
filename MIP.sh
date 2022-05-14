#!/bin/bash

Banner (){
toilet -F gay M I P
printf " (MAC)\t    (IP Address)   (Proxychains)\n"
printf "\n\t\t\t\t\t"

echo $'\e[1;33m'-- Powered By: Cyberspecs$'\e[0m'

printf "\n\n"

printf "%0.s#" {1..70} 
}

Interfaces (){
printf "\n\nSelect an interface to work with:\n"
printf "%0.s-" {1..40} 
printf "\n"
ifconfig -a | sed -E 's/[[:space:]:].*//;/^$/d'
printf "%0.s-" {1..40} 
printf "\n> "
}

actions (){
clear

Banner

printf "\n\nSelect an option from menu: \n"
printf "%0.s-" {1..40} 
printf "\n[1] Change your MAC Address with random MAC Address \n[2] Change your MAC Address with specific MAC Address\n[3] Change your IP Address with specific IP Address\n[4] Start Proxychain server\n[5] Exit\n"
printf "%0.s-" {1..40} 
printf "\n> "
read choice

if [ $choice == 1 ];
then
  clear
  
  Banner

  Interfaces
  
  read interface_name
  
  printf "\n"
  
  sudo macchanger -r $interface_name
  
  sleep 5
 
elif [ $choice == 2 ];
then
  clear

  Banner
  
  Interfaces
  
  read interface_name
  
  printf "New MAC Address > "
  
  read new_MAC
  
  printf "\n"
  
  sudo macchanger -m --mac=$new_MAC $interface_name
  
  sleep 5
 
elif [ $choice == 3 ];
then 
  clear 
  
  Banner
  
  Interfaces
  
  read interface_name
  
  printf "New IP Address > "
  
  read new_IP
  
  sudo ifconfig $interface_name down
  sudo ifconfig $interface_name inet $new_IP
  sudo ifconfig $interface_name up  
  
  printf "\n\nYour New IP Address is $new_IP"
  
  sleep 5

elif [ $choice == 4 ];
then 
  service tor start
  
  sed -i 's/# dynamic_chain/dynamic_chain/' /etc/proxychains4.conf
  sed -i 's/strict_chain/# strict_chain/' /etc/proxychains4.conf
  
  echo "socks5  127.0.0.1 9050" >> /etc/proxychains4.conf
  
  clear 
  
  Banner
  
  printf '\n\nEnter the service name, to open it with proxychain > '
  read service_name
  
  printf 'Argument > '
  read Argument
  
  printf "\n"
  
  proxychains $service_name $Argument

elif [ $choice == 5 ];
then 
  exit 1
 
else

  clear
  Banner
  printf "\n\nInvalid Choice\n"
  
  sleep 2
  
fi
}

printf "INSTALLING REQUIRED PACKAGES\n"
printf "%0.s-" {1..75} 
printf "\n"
sudo apt-get install toilet
sudo apt-get install macchanger
sudo apt-get install proxychains
sudo apt-get install tor

clear

Banner

printf "\n\n"
s="This tool wil help you to STAY ANONYMOUS !"

for ((i=0; i<${#s} ; i++)) ; do 
  echo -n "${s:i:1}"
  sleep 0.05
  
done

sleep 1

while [ 1 == 1 ];do
  actions
done 