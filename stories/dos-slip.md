<title>DOS Network Connectivity via SLIP - Dave's World</title>

How I connected a DOS laptop to the Internet by becoming my own SLIP ISP
========================================================================

### August 6, 2018

Since 2016 when I first installed FreeDOS on my 1998-vintage laptop (yes, the
same one mentioned in [this article](decoding-ymg.html)), I've been trying
on-and-off to get it connected to the network. The real hangup was that I
didn't understand DOS networking to begin with, and the laptop itself doesn't
have any modern networking hardware on it.

<img src="/res/photos/dostop.jpg" width="640" alt="My humble DOStop">

Behold, my router:

<img src="/res/photos/router.jpg" width="640" alt="My home router">

While it is quite stylish, its only interfaces to the outside world are
Ethernet ports and WiFi. While this is just fine for common home networking, it
simply won't cut it for my poor DOStop. The DOStop is equipped with a built-in
telephone modem, but since I lack a landline phone connection, this is fairly
useless to me. I looked to the FreeDOS user mailing list for assistance getting
this thing online. They mentioned some protocols that I kept note of but took a
while getting around to researching. Among these were Serial Line Internet
Protocol (SLIP). Now, the DOStop does have a serial port on the rear, so
theoretically I could use it. Enter INCO:

<img src="/res/photos/inco.jpg" width="640" alt="INCO the Neoware thin client">

INCO is a mid-2000s Neoware thin client that was given to me by a friend
collecting old hardware being thrown out by a local business. It's only got
120MB of internal storage, and I originally installed TinyCore Linux on it
since it's basically the only distro that will fit. However, by adding some
extra storage via USB, I was able to install Debian GNU/Linux on it, which was
crucial since TinyCore omits SLIP drivers in its kernel distribution. I could
theoretically have installed a custom kernel (and I even got as far as having
it compiled), but the TinyCore documentation just isn't clear enough for a
kernel novice like myself to be able to install it.

Now with INCO being a thin client, it has an Ethernet controller of its own for
the purposes of network booting. This means I could use it as a bridge if I
could establish a SLIP connection between it and the DOStop. Observe:

<img src="/res/photos/dostop-rear.jpg" width="640" alt="Rear of the DOStop">

<img src="/res/photos/inco-rear.jpg" width="640" alt="Rear of INCO">

Now all I needed was software. Initially, I had thought I would need to
implement most of the software myself. I knew that on the DOS side I needed a
packet driver which uses SLIP and on the Linux side I needed a way of accepting
those transmissions and translating them over the Ethernet lines. As it turns
out, all the software already existed! Crynwr Software has published a SLIP
packet driver since 1993, and Linux has SLIP support built in (as long as your
distro includes it).

I downloaded mTCP for DOS which included a how-to guide on setting up SLIP
connectivity. This along with the other documentation I had gathered up proved
immensely helpful, and I was able to go from zero to Internet in a single
day. Here's how it's done:

### The hardware

The computers should be connected via a null modem serial cable. Mine happens
to be a straight-through cable attached to a null modem adapter. It's important
to understand that this setup will only involve 3 wires (and one of them is
just a common ground). We'll eventually need to set up our software
configuration appropriately for this setup.

### Network planning

While many DOS TCP stacks support DHCP, it's simply easier to go with a static
IP if at all possible, and that's what the mTCP guide covered, and it's what
I'll cover here since it's what I've done. The mTCP guide uses the following
method for determining IP addresses for this setup:

- Select a number that is divisible by 4, not 0, and strictly less than 252.
- Make sure that no host on your network claims that address or the next 3
  after it (at the end of the address, e.g. 192.168.1.16 through 192.168.1.19).
- The Linux machine will be assigned that number plus 1.
- The DOS machine will be assigned that number plus 2.
- The remaining 2 numbers will be reserved.

My router is configured never to assign an automatic DHCP lease with an address
less than 100. I statically set INCO (the Linux host) to receive address 4 when
it requests its DHCP address (it's reserved for this setup, so I can claim it).
I'll use 5 for one side of the bridge and 6 for the other.

### The Linux side

All of these commands are run as `root` (hence the leading `#`). A prerequisite
is the `net-tools` package available on most distros. Also, you need to make
sure your kernel supports SLIP. There is a SLIP driver built into Linux, but
many distros do not include it in their kernel builds since it has fallen out
of popularity in favor of PPP. You can run the command `modprobe slip` to see
if the module can be loaded.

First, we need to prepare the virtual terminal for our purposes:

    # stty -F "$TTY" -clocal -crtscts "$BAUD"

where `$TTY` is the virtual terminal (in my case `/dev/ttyS0`) and `$BAUD` is
the baud rate (in my case 115200). This disables sending modem control signals
and attempting RTS/CTS handshaking over the serial line. This is because of the
limited number of wires available in our simple null modem setup.

Next, we attach our serial line to a network interface:

    # slattach -d -v -L -m -p slip -s "$BAUD" "$TTY" &

Options `-d` and `-v` are only there so that we can see clearly whether it
worked. `-L` says to use 3-wire mode, `-m` says to not initialize the line into
8 bits raw mode, `-p slip` says to use normal SLIP (as opposed to compressed
header SLIP or CSLIP which is the default), and `-s "$BAUD"` sets the baud rate
on the line. We add the `&` at the end, because this is technically a daemon
that will continue running in order to maintain the link.

If all this worked, it should have created a network interface called
`sl0`. But this is a brand new interface that needs to be set up manually.

    # ifconfig sl0 "$GATEWAY" pointopoint "$IP" mtu "$MTU" up

Here we set up this interface as a point-to-point interface, first setting the
IP address we assigned to the Linux box for this link, in my case 192.168.10.5
(called `$GATEWAY` because it is the gateway from the DOS side's perspective),
then setting mode `pointopoint` (no that's not a typo), then setting the IP
address on the other side of the link (`$IP`, or 192.168.10.6 in my case), the
MTU (in my case 576 by recommendation of mTCP), and setting the interface `up`.

This is actually good enough to get our DOS box communicating via IP with the
Linux bridge itself, but we also want it to be able to see the rest of the LAN
as well as the Internet. For this we need to reroute any ARP requests trying to
reach the DOS box.

    # arp -s "$IP" "$MAC" pub

Here, `$MAC` is the hardware address of the Linux box's Ethernet
controller. You can find it by running `ifconfig` and checking the `ether`
property of your Ethernet interface.

Lastly, we need to enable IP forwarding:

    # echo 1 >/proc/sys/net/ipv4/ip_forward

With that, we're done with the Linux side.

### The DOS side

I'm going to assume you have a hard drive assigned to `C:`. If not, I trust you
are savvy enough to modify my instructions appropriately.

The DOS side is considerably simpler. First, download [Crynwr][1] and [mTCP][2]
on your main PC. From Crynwr, we're looking for `ETHERSL.COM` which is our SLIP
packet driver, and we also want all the programs from mTCP. Get these onto your
DOS box via sneakernet.

First, we'll load the packet driver:

    ETHERSL %INT% %IRQ% %IOADDR% %BAUD%

where `%INT%` is the interrupt to be used by the driver (in my case, `0x60`),
`%IRQ%` is the IRQ used by your serial controller (in my case, 4), `%IOADDR%`
is the I/O address of your serial port (in my case `0x3f8`), and `%BAUD%` is
the same baud rate we set up on the Linux side. With any luck, this will
install successfully and tell you its new Ethernet address in the console. We
don't need this address for our purposes, but if you see it then that means
it's working.

Technically we're done, but we'll need to configure mTCP in order to use those
applications we just downloaded. First set two environment variables:

    SET MTCPSLIP=true
    SET MTCPCFG=C:\MTCP.CFG

This tells mTCP that we're using SLIP (which is important) and where it can
find its config file (which we're about to create). Open `C:\MTCP.CFG` with
your favorite text editor. The first lines we need to enter are about our basic
setup. Be sure to adjust your own configs if you chose something different from
my setup.

    PACKETINT 0x60
    MTU 576
    HOSTNAME slowpoke

    IPADDR 192.168.10.6
    NETMASK 255.255.255.252
    GATEWAY 192.168.10.5
    NAMESERVER 192.168.10.1

Be sure to come up with your own cool hostname; just don't use
punctuation. Note the `NETMASK` which is important and based on our numbering
scheme. `NAMESERVER` here refers to my router's IP address since it also serves
DNS. Change yours appropriately.

You can add more lines to this config as instructed in the various text manuals
for the different mTCP applications.

Finally we're done! Try pinging some other hosts on your network and some
Internet servers, even with domain names!

<img src="/res/photos/afterhours.jpg" width="640" alt="After Hours BBS">

<img src="/res/photos/ircjr.jpg" width="640" alt="IRCjr IRC client">

Epilogue
--------

You may notice that mTCP is rather simple, and a lot of DOS network
applications use WatTCP instead. You'll need to translate your configuration
over. You can write a simple configuration as follows in `C:\WATTCP.CFG`
(again, translate to your particular setup):

    my_ip = 192.168.10.6
    netmask = 255.255.255.252
    gateway = 192.168.10.5
    nameserver = 192.168.10.1

Finally, set the environment variable so that WatTCP applications know where to
look:

    SET WATTCP.CFG=C:\

Also very important is easy repeatability of this setup. I have created 4
scripts that can be run to easily recreate this setup. On the Linux side, I
added some handy beeps to indicate progress or failure if you are starting this
headless (say, on boot). This requires the `beep` package be installed.

- [slipup.sh][3] to start up the Linux side
- [SLIPUP.BAT][4] to start up the DOS side
- [slipdown.sh][5] to take down the Linux side
- [SLIPDOWN.BAT][6] to take down the DOS side

Be sure to also put entries in your `AUTOEXEC.BAT` file to set the environment
variables used for the config files.

Eventually I also plan to do this with the PLIP protocol, which is essentially
the same thing but over the parallel port. That way I can free up my serial
port for things that can only be done over serial (like XMODEM transfers).

[1]: http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/crynwr.html
[2]: http://www.ibiblio.org/pub/micro/pc-stuff/freedos/files/distributions/1.2/repos/pkg-html/mtcp.html
[3]: /res/dos/slipup.sh
[4]: /res/dos/SLIPUP.BAT
[5]: /res/dos/slipdown.sh
[6]: /res/dos/SLIPDOWN.BAT
