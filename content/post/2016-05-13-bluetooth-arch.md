---
title: Bluetooth on Arch
tags: [ps3-controller, bluetooth, arch-linux]
---

Well, today I had a "fun" little diversion.<br/>
I started out by wanting to connect a game controller to my crappy little Dell Mini so I can start prototyping some games.
Of course a controller isn't required, but I like controllers and it seemed like a small little learning exercise.<br/>
If you know me and my experience with computers, then you'll know that this didn't go as planned.  Also, why would I be writing about it if it did? :-)

I'm running a console-only installation of Arch Linux with systemd.  That should give you context for the following, and if your environment is different then you'll have to modify the appropriate commands accordingly.  I'm also talking specifically about using a USB bluetooth adapter, though I just checked and apparently this little netbook has built-in bluetooth.

Before starting, let's assess our current USB situation:

    lsusb

Take note of what's showing.
Now plug in the usb bluetooth adapter and check again:

    lsusb

Make sure the device shows up properly.

Now, I don't have any bluetooth utilities installed by default, so I have to set that up:

    sudo pacman -S bluez bluez-utils
    modprobe btusb
    grep btusb /proc/modules # Make sure the kernel module is loaded
    systemctl start bluetooth
    systemctl status bluetooth # Verify the bluetooth service is working

At this point I had a problem.<br/>
The primary issue is that trying to execute `scan on` from `bluetoothctl` would tell me that the bluetooth device wasn't ready.  I had a difficult time resolving it, and started resolving a secondary issue that may or may not have been related.  I noticed in the `systemctl status bluetooth` call an error message regarding **sap-server** which lead me to some resources.<sup><a href="#2016-05-13_ref1">1</a></sup>
By following a comment on that bug, I was able to resolve the problem.

    sudo mkdir /etc/systemd/system/bluetooth.service.d
    sudo $EDITOR /etc/systemd/system/bluetooth.service.d/customexec.conf
    # Now in customexec.conf:
    [Service]
    ExecStart=
    ExecStart=/usr/lib/bluetooth/bluetoothd --noplugin=sap
    # Out of the file now:
    systemctl stop bluetooth
    systemctl start bluetooth
    systemctl status bluetooth

Now that problem has been resolved.  But I still can't scan...<br/>
Thankfully the solution is extremely simple:

    bluetoothctl
    > power on # This is the problem!
    > scan on

Voila!

Well, the whole goal was to get a controller talking with my laptop which I opted to do via bluetooth and I got bluetooth working... however, I brought a PS3 controller to try with.  Unfortunately, PS3 controllers use a proprietary protocol on top of bluetooth and can't be paired with normally. See more info.<sup><a href="#2016-05-13_ref2">2</a></sup>  I should have known this already, because you have to connect a PS3 controller via USB cable to a host PS3 system to get it to pair with that system.  Well, luckily enough there is a utility you can download called `sixpair` that's available in the AUR.  Unfortunately, simply using `sixpair` on its own isn't enough.

And thus, the end of my journey with connecting the PS3 controller to my laptop.  At least for now.

----

#### Footnotes
<sub><sup id="2016-05-13_ref1">1</sup><a href="https://bugs.archlinux.org/task/41247">Arch Bluetooth Issue</a></sub><br/>
<sub><sup id="2016-05-13_ref2">2</sup><a href="http://www.pabr.org/sixlinux/sixlinux.en.html">PS3 Controller Bluetooth Guide</a></sub><br/>
