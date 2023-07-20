#!/bin/bash

#Start with Buster with desktop 
#get from here https://www.raspberrypi.org/downloads/raspbian/

#Also works with arm64 on Raspberry Pi 4. (NOT JS8CALL)


sudo apt-get update -y
sudo apt-get upgrade -y


#Install Tools - Not needed but good to have.
sudo apt-get install -y mc inxi

#Install build tools
sudo apt-get install -y build-essential cmake libusb-1.0-0-dev git libx11-dev

#Install Ham radio stuff. 
sudo apt-get install -y hamradio-antenna hamradio-datamodes hamradio-digitalvoice hamradio-morse hamradio-nonamateur hamradio-packetmodes hamradio-rigcontrol hamradio-satellite hamradio-sdr hamradio-tools linpac wsjtx gqrx-sdr
sudo apt-get purge -y radioclk

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


sudo apt install -y libglfw3-dev libglew-dev libairspyhf-dev libiio-dev libad9361-dev libairspy-dev librtlsdr-dev portaudio19-dev libzstd1 libzstd-dev libhackrf-dev 


### From https://www.radiosrs.net/installing_SDRPlusPlus.html

cd ~/build
git clone https://github.com/AlexandreRouma/SDRPlusPlus.git

cd SDRPlusPlus
mkdir build
cd build
cmake .. -DOPT_BUILD_SDRPLAY_SOURCE:BOOL=ON -DOPT_BUILD_NEW_PORTAUDIO_SINK:BOOL=ON -DOPT_BUILD_M17_DECODER:BOOL=ON
make -j4
sudo make install
sudo ldconfig

### https://gitlab.com/eliggett/wfview.git
#sudo apt install -y qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
#sudo apt install -y libqt5core5a libqt5serialport5 libqt5serialport5-dev libqt5multimedia5 libqt5multimedia5-plugins qtmultimedia5-dev libopus-dev libeigen3-dev portaudio19-dev librtaudio-dev  libqt5gamepad5-dev
#sudo apt-get install -y libqcustomplot2.0 libqcustomplot-doc libqcustomplot-dev

#cd ~/build
#git clone https://gitlab.com/eliggett/wfview.git
#mkdir build
#cd build
#qmake ../wfview/wfview.pro
#make -j4
#sudo make install

echo "END"








