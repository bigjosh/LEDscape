#!/usr/bin/env bash

if [[ ! -f ledscape.c ]]; then

	echo "Could not find ledscape.c. Must run from inside the LEDscape directory."
	exit -1
fi

echo "Making ledscape..."
make

if [[ ! -f "/boot/dtbs/$(uname -r)/am335x-boneblack.dtb" ]]; then

	echo "Could not find "/boot/dtbs/$(uname -r)/am335x-boneblack.dtb". Only works with the Wheezy version of Debian."
	exit -1

fi



echo "Making backups of old device tree files..."
mkdir /boot/dtbs/$(uname -r)/ledscape.bak
cp /boot/dtbs/$(uname -r)/am335x-boneblack.dtb{,.preledscape_bk}    
cp /boot/dtbs/$(uname -r)/am335x-bonegreen.dtb{,.preledscape_bk}    

echo "Copying new device tree files..."		
cp devicetree/am335x-boneblack.dtb /boot/dtbs/$(uname -r)/ 
cp devicetree/am335x-bonegreen.dtb /boot/dtbs/$(uname -r)/ 

echo Copying config file to /etc

if [[ -f "//etc/ledscape-config.json" ]]; then

	echo Leaving existing /etc/ledscape-config.json intact. 
	
else

	cp configs/ws281x-config.json /etc/ledscape-config.json
	
fi

echo "Enabling kernel module..."	
modprobe uio_pruss  


echo "Done. Please enter reboot to reboot the machine and enable changes."
		
