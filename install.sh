#!/bin/bash

#Start with Buster with desktop 
#get from here https://www.raspberrypi.org/downloads/raspbian/

#Also works with arm64 on Raspberry Pi 4. (NOT JS8CALL)


sudo apt-get update -y
sudo apt-get upgrade -y


#Install Tools - Not needed but good to have.
sudo apt-get install -y mc inxi

#Install build tools
sudo apt-get install -y build-essential cmake libusb-1.0-0-dev git libx11-dev -y

#Install Ham radio stuff. 
sudo apt-get install -y hamradio-antenna hamradio-datamodes hamradio-digitalvoice hamradio-morse hamradio-nonamateur hamradio-packetmodes hamradio-rigcontrol hamradio-satellite hamradio-sdr hamradio-tools linpac wsjtx gqrx-sdr

#Create build directory
mkdir ~/build
cd ~/build

#RTL-SDR Driver
echo 'blacklist dvb_usb_rtl28xxu' | sudo tee --append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr/
mkdir build
cd build
cmake ../
make -j4
sudo make install
sudo cmake ../ -DINSTALL_UDEV_RULES=ON
sudo ldconfig
#Check in CubicSDR

cd ~/build
wget http://files.js8call.com/2.2.0/js8call_2.2.0_armhf.deb
#wget http://files.js8call.com/2.1.1/js8call_2.1.1_armhf.deb
sudo dpkg -i js8call_2.2.0_armhf.deb
sudo apt --fix-broken install
sudo dpkg -i js8call_2.2.0_armhf.deb
sudo apt install -f -y

#Get Direwolf Config
wget -O ~/direwolf.conf https://raw.githubusercontent.com/RattyDAVE/raspberry-pi-hamradio/master/direwolf.conf

#Allow Pi to run xastir
sudo usermod -a -G xastir-ax25 pi

