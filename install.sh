#!/bin/bash

#Start with Buster with desktop 
#get from here https://www.raspberrypi.org/downloads/raspbian/

#Also works with arm64 on Raspberry Pi 4. (NOT JS8CALL)

#For NVME
cat <<EOF >> /boot/firmware/config.txt
dtparam=nvme
dtparam=pciex1_gen=3
EOF

# Change boot order
# sudo rpi-eeprom-config --edit

cat <<EOF > /tmp/boot.conf
[all]
BOOT_UART=1
POWER_OFF_ON_HALT=1
#NVME
#BOOT_ORDER=0xf416
#SD Card only
BOOT_ORDER=0x1
PCIE_PROBE=1
EOF

sudo rpi-eeprom-config -c /tmp/boot.conf



sudo apt-get update -y
sudo apt-get upgrade -y

#Needed for the module/*/build directory
sudo apt install --reinstall raspi-firmware
reboot
sudo apt install linux-headers-rpi-v8



#Install Tools - Not needed but good to have.
sudo apt-get install -y mc inxi

#Install build tools
sudo apt-get install -y build-essential cmake libusb-1.0-0-dev git libx11-dev

#Install Ham radio stuff. 
sudo apt-get install -y hamradio-antenna hamradio-datamodes hamradio-digitalvoice hamradio-morse hamradio-nonamateur hamradio-packetmodes hamradio-rigcontrol hamradio-satellite hamradio-sdr hamradio-tools linpac wsjtx gqrx-sdr qjackctl
sudo apt-get purge -y radioclk

#Create build directory
mkdir ~/build
cd ~/build

#RTL-SDR Driver
#Provides 25MHz-1700M
#echo 'blacklist dvb_usb_rtl28xxu' | sudo tee --append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf
#git clone git://git.osmocom.org/rtl-sdr.git
#cd rtl-sdr/
#mkdir build
#cd build
#cmake ../
#make -j4
#sudo make install
#sudo cmake ../ -DINSTALL_UDEV_RULES=ON
#sudo ldconfig
#Check in CubicSDR

#RTL-SDR Driver v4
cd ~/build
git clone https://github.com/rtlsdrblog/rtl-sdr-blog
cd rtl-sdr-blog/
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make -j4
sudo make install
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/
sudo ldconfig
echo 'blacklist dvb_usb_rtl28xxu' | sudo tee --append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf





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

### From https://www.radiosrs.net/installing_SDRPlusPlus.html
#sudo apt install -y libfftw3-dev libglfw3-dev libglew-dev libvolk2-dev libsoapysdr-dev libairspyhf-dev libairspy-dev libiio-dev libad9361-dev librtaudio-dev libhackrf-dev librtlsdr-dev libbladerf-dev liblimesuite-dev
#sudo apt install -y libglfw3-dev libglew-dev libairspyhf-dev libiio-dev libad9361-dev libairspy-dev librtlsdr-dev portaudio19-dev libzstd1 libzstd-dev libcodec2-dev
#sudo apt-get install libvolk2-dev librtaudio-dev libhackrf-dev libfftw3-dev libsoapysdr-dev




sudo apt-get install libglfw3-dev libfftw3-dev libvolk2-dev libzstd-dev librtaudio-dev portaudio19-dev libcodec2-dev
cd ~/build
git clone https://github.com/AlexandreRouma/SDRPlusPlus.git
cd SDRPlusPlus
git pull
mkdir build
cd build
cmake .. \
    -DOPT_BUILD_AIRSPY_SOURCE:BOOL=OFF \
    -DOPT_BUILD_AIRSPYHF_SOURCE:BOOL=OFF \
    -DOPT_BUILD_HACKRF_SOURCE:BOOL=OFF \
    -DOPT_BUILD_PLUTOSDR_SOURCE:BOOL=OFF \
    -DOPT_BUILD_RTL_SDR_SOURCE:BOOL=ON \
    -DOPT_BUILD_SDRPLAY_SOURCE:BOOL=OFF \
    -DOPT_BUILD_SOAPY_SOURCE:BOOL=OFF \
    -DOPT_BUILD_SPECTRAN_SOURCE:BOOL=OFF \
    -DOPT_BUILD_ATV_DECODER:BOOL=ON \
    -DOPT_BUILD_FALCON9_DECODER:BOOL=OFF \
    -DOPT_BUILD_M17_DECODER:BOOL=ON \
    -DOPT_BUILD_PAGER_DECODER:BOOL=ON \
    -DOPT_BUILD_WEATHER_SAT_DECODER:BOOL=OFF \
    -DOPT_BUILD_NEW_PORTAUDIO_SINK:BOOL=ON
make -j4
sudo make install
sudo ldconfig
cat <<EOF | sudo tee /etc/systemd/system/sdrpp.service
[Unit]
Description=SDR++ Server
After=network.target
[Service]
User=pi
Group=pi
Environment="LOG_NO_TIME=true"
ExecStart=/usr/bin/sdrpp --server
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable sdrpp
sudo systemctl start sdrpp





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

wget -O - https://repo.openwebrx.de/debian/key.gpg.txt | gpg --dearmor -o /usr/share/keyrings/openwebrx.gpg
echo "deb [signed-by=/usr/share/keyrings/openwebrx.gpg] https://repo.openwebrx.de/debian/ bullseye main" > /etc/apt/sources.list.d/openwebrx.list
apt-get update -y
apt-get install -y openwebrx
systemctl enable openwebrx
systemctl start openwebrx
#http://127.0.0.1:8073


#arm_64bit=0 at the end of /boot/config.txt
cd /tmp
wget https://raw.githubusercontent.com/pa3gsb/Radioberry-2.x/master/SBC/rpi-4/releases/dev/radioberry_install.sh
sudo chmod +x radioberry_install.sh
./radioberry_install.sh

cd /tmp
wget https://raw.githubusercontent.com/pa3gsb/Radioberry-2.x/master/SBC/rpi-4/releases/dev/pihpsdr_install.sh
chmod +x pihpsdr_install.sh
./pihpsdr_install.sh

#SparkSDR
cd /tmp
wget https://www.sparksdr.com/download/SparkSDR.2.0.33.linux-arm64.deb
dpkg -i SparkSDR.2.0.33.linux-arm64.deb 


curl -sSL https://get.docker.com | sh

docker volume create openwebrx-config
docker volume create openwebrx-settings

docker run \
	-d \
	--name openwebrx \
	--device /dev/bus/usb \
	--device /dev/radioberry \
	-p 8073:8073 \
	--tmpfs=/tmp/openwebrx \
	-v openwebrx-config:/etc/openwebrx \
	-v openwebrx-settings:/var/lib/openwebrx \
	jketterl/openwebrx-radioberry:stable

#docker run \
#	-d \
#	--name openwebrx \
#	--device /dev/bus/usb \
#	--device /dev/radioberry \
#	-p 8073:8073 \
#	--tmpfs=/tmp/openwebrx \
#	-v openwebrx-config:/etc/openwebrx \
#	-v openwebrx-settings:/var/lib/openwebrx \
#	slechev/openwebrxplus-nightly

docker run \
	-d \
	--name openwebrx \
	--device /dev/bus/usb \
	--device /dev/radioberry \
	-p 8073:8073 \
	--tmpfs=/tmp/openwebrx \
	-v openwebrx-config:/etc/openwebrx \
	-v openwebrx-settings:/var/lib/openwebrx \
        slechev/openwebrxplus-softmbe

#docker exec -it [container] python3 /opt/openwebrx/openwebrx.py admin adduser [username]

docker exec -it openwebrx python3 /opt/openwebrx/openwebrx.py admin adduser admin
docker exec -it openwebrx /bin/bash

	apt-get update
	apt-get install -y wget gpg
	wget -O - https://repo.openwebrx.de/debian/key.gpg.txt | gpg --dearmor -o /usr/share/keyrings/openwebrx.gpg
	echo "deb [signed-by=/usr/share/keyrings/openwebrx.gpg] https://repo.openwebrx.de/debian/ bullseye main" > /etc/apt/sources.list.d/openwebrx.list
	apt-get update
	apt-get install -y owrx-connector rtl-sdr

docker stop openwebrx
docker start openwebrx 

echo "END"








