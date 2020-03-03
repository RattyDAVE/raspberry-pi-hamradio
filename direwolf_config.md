Direwolf Config PDF - https://raw.githubusercontent.com/wb2osz/direwolf/master/doc/User-Guide.pdf

Now we can setup Direwolf. First we have a look about our sound card in- and output

To find the devices we can use ```aplay -l``` and ```arecord -l```.

```
aplay -l
```

On your machine this may be different but on my machine the output is:

```
pi@raspberrypi:~ $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ALSA [bcm2835 ALSA], device 0: bcm2835 ALSA [bcm2835 ALSA]
  Subdevices: 7/7
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
card 0: ALSA [bcm2835 ALSA], device 1: bcm2835 IEC958/HDMI [bcm2835 IEC958/HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: ALSA [bcm2835 ALSA], device 2: bcm2835 IEC958/HDMI1 [bcm2835 IEC958/HDMI1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Device [USB Audio Device], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

The section we are intrested in is at the bottom

```
card 1: Device [USB Audio Device], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

For the record device this is much shorter as the Raspberry Pi does not have a input.

```
arecord -l
```

And again on my machine it is the following. 

```
pi@raspberrypi:~ $ arecord -l
**** List of CAPTURE Hardware Devices ****
card 1: Device [USB Audio Device], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
```

Now we edit the Direwolf config file

```
sudo nano /etc/direwolf.conf
```

Scroll down to the line: #ADEVICE – plughw:1,0 and delete the # from the start of both lines. 

Scroll down to CHANNEL 0 PROPERTIES and replace NOCALL with your callsign, 

Press Ctrl+x, close an save the file.

Now you can start Direwolf.

```
direwolf -t 0 -c /etc/direwolf.conf
```


After start you see infos from Dirwolf bevor it begins to decode APRS messages. You will see that Hamlib ist enabled, the active audio device, info about your active channels and config and the info that Direwolf is ready to accept AGW (Port 8000) and KISS TCP (Port 8001). We need AGW for connect Xastir.

All stations use a single frequency. On the VHF 2m band - the most commonly used band for APRS - APRS uses 144.800MHz in Europe and 144.390MHz in the USA.
