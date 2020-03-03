#!/bin/bash

#Install Tools - Not needed but good to have.
sudo apt-get install mc inxi

#Install Ham radio stuff. 
sudo apt-get install hamradio-antenna hamradio-datamodes hamradio-digitalvoice hamradio-morse hamradio-nonamateur hamradio-packetmodes hamradio-rigcontrol hamradio-satellite hamradio-sdr hamradio-tools linpac wsjtx gqrx-sdr

#Install build tools
sudo apt-get install build-essential cmake libusb-1.0-0-dev git libx11-dev -y

#Create build directory
cd ~
mkdir ~/build
cd build

#RTL-SDR Driver
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
wget http://files.js8call.com/2.1.1/js8call_2.1.1_armhf.deb
sudo dpkg -i js8call_2.1.1_armhf.deb
sudo apt --fix-broken install
sudo dpkg -i js8call_2.1.1_armhf.deb
