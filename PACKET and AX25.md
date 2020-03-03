You need to complete the direwolf config and also get the callpass as you will need it.

https://github.com/RattyDAVE/raspberry-pi-hamradio/blob/master/direwolf_config.md

You also need an Amature Radio IP address. This is in the 44.x.x.x range.
You can request one from here http://wiki.ampr.org/wiki/Requesting_a_block

----

```
sudo nano /etc/ax25/axports
```

Add the following, but replacing CALLSIGN with your callsign.

```
ax0 CALLSIGN 1200 255 2 Packet
```

Leave with ctrl+x and save and reboot

Stop Direwolf if running and run with the added -p option.

```
direwolf -t 0 -c /etc/direwolf.conf -p
```

When direwolf starts it will show the TNC port. Yours may be different.

```
Virtual KISS TNC is available on /dev/pts/2
```


We can now start kissattach. Replace /dev/pts/2 with yours and also replace the IP address with your IP address.

```
sudo /usr/sbin/kissattach /dev/pts/2 ax0 44.x.x.x
```


Now we can install Linpac. Open the raspbian menu settings: add / remove Software, search for linpac, select it and Apply. Start linpac with:

sudo linpac -m
Now linpac should run and you can adjust your individual setup. When ready make a reboot.
