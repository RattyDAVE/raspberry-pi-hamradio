You need to complete the direwolf config and also get the callpass as you will need it.
- https://github.com/RattyDAVE/raspberry-pi-hamradio/blob/master/direwolf_config.md

Direwolf needs to be running.

Note:
- All stations use a single frequency. On the VHF 2m band - the most commonly used band for APRS - APRS uses 144.800MHz in Europe and 144.390MHz in the USA.

----

Load XASTIR from the menus.

In the first menu that comes up, set your callsign to {my-real-call}-10 and (if desired) set your lat/long/position ambiguity.

In Interface -> Interface Control, Add, Networked AGWPE, Add. 

The defaults are fine for now. 
Select SAVE and START.

You should see a connection made on the Direwolf screen.

OPTIONAL

Interface -> Interface Control, Add, Internet Server, Add. Set Pass-code to `callpass` save and Start. 

Now you’re getting APRS from the network as well.

Want to see it on maps? I wasn’t able to get all the maps going, but things worked when I picked Maps -> Map Chooser and selected only Online/osm_tiled_mapnik.geo and worldhi.map.
