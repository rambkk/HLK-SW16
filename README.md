# HLK-SW16 scripts

Scripts to interface HLK-SW16 which is the IP ready (Wired and Wifi) 16x relay switches electronic module.<br />
The input/output commands has been derived from captured network packets and also from https://github.com/jameshilliard/HLK-SW16-FW

Normally this hardware will try to connect via UDP to a server on the internet to allow traffic redirection from HLK-16 official clients to make a connection. However, this module also listens on TCP port 8080 (default configuration) and could be controlled directly through this channel.

----------
<b>Requirement:</b>

HLK-SW16 module

The scripts require Bash, Ncat and other basic utilities (sed, tr, and od)<br />
-Tested with Bash [GNU bash, version 4.3.48(1)-release] and ncat [Ncat: Version 7.01 ( https://nmap.org/ncat )]

---------
<b>Using the script:</b>

In this project, scripts will make direct connection to the module via TCP port 8080 to perform the followings:

(relaytoggle.sh)<br />
-Switch on a specified relay switch<br />
-Switch off a specified relay switch<br />
-Switch on all relay switches<br />
-Switch off all relay switches<br />
 

(relaystatus.sh)<br />
-Get the current status of each relay switch<br />

# License
<pre>
Copyright (C) 2018 Ram Narula ram@pluslab.com
Licensed under the GPL-3.0 license.
(See the LICENSE file for the whole license text.)
</pre>

