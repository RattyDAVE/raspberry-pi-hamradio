Direwolf Config PDF - https://raw.githubusercontent.com/wb2osz/direwolf/master/doc/User-Guide.pdf

Now we can setup Direwolf. First we have a look about our sound card in- and output

# l is a lower case L
aplay -l
arecord -l 
Now we edit the Direwolf config file

sudo nano direwolf.conf
Scroll down to the line: #ADEVICE – plughw:1,0 and delete the # from the start of both lines. Scroll down to CHANNEL 0 PROPERTIES and replace NOCALL with your callsign, i.e. DL1GKK. NB: This must be caps. Then, if you like to use Hamlib scroll to ptt and change it (in my case) to: PTT RIG 229 /dev/ttyUSB0

Press Ctrl+x, close an save the file. Then make a reboot.

Now you can start Direwolf. I use LXTerminal and enter “direwolf”. In my case the text is blinking. I think it’s a problem with the colors and I don’t have a solution yet. The first remedy is to call Direwolf with “direwolf -t 0”. The colours are then switched off and everything is black and white. When I have found a solution to the problem I will post here again. If someone knows a solution please mail to info@dach-ok.de

After start you see infos from Dirwolf bevor it begins to decode APRS messages. You will see that Hamlib ist enabled, the active audio device, info about your active channels and config and the info that Direwolf is ready to accept AGW (Port 8000) and KISS TCP (Port 8001). We need AGW for connect Xastir.
