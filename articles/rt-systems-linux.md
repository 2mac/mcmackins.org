<title>How to use RT Systems cables with CHIRP on Linux - Dave's World</title>

Using RT Systems cables on Linux
================================

I prefer to use CHIRP for programming my radios since I can easily copy
channels between different models of radio and since it is [free
software][1]. However, it's not always easy to find a generic programming cable
for any given radio. RT Systems makes proprietary programming software that you
have to buy for each model of radio you have, but some retailers will sell you
their programming cables without a software license.

These programming cables are just FTDI serial cables with a proprietary vendor
and product code, so operating systems fail to identify the correct driver to
load for them. On Windows, this would be a matter of installing RT Systems' own
driver package, but on Linux, we can simply use udev to create a simple rule to
identify all RT Systems products as FTDI serial compatible.

The Driver
----------

If your distro does not ship it by default, you'll need to install the
`ftdi_sio` kernel module.

The udev rule
-------------

I put my rule in `/etc/udev/rules.d/99-custom.rules`. You can choose your own
file name here, but I recommend starting its name with "99" to make sure it
only runs after all other udev rules have processed it.

Here are the contents of the file:

    ATTRS{idVendor}=="2100", RUN+="/sbin/modprobe -q ftdi_sio", RUN+="/bin/sh -c 'echo 2100 $attr{idProduct} >/sys/bus/usb-serial/drivers/ftdi_sio/new_id'"

`2100` is the vendor ID for RT Systems. This rule tells udev to run two
commands when it detects an RT Systems cable. First, it loads the `ftdi_sio`
driver module if it is not already loaded. Then, it sends a signal to the
driver to load it for the vendor ID and product ID of the device it just
detected.

Now what?
---------

Once you've got this written, the udev daemon should automatically reload the
rules. If you already have the cable connected, unplug it now and plug it back
in. The rule will identify the cable, and you can check `dmesg` to see which
device node has been assigned to it. It will resemble `/dev/ttyUSB0`. You can
then tell CHIRP to use that device and get to programming!

[1]: https://gnu.org/philosophy/free-sw.html
