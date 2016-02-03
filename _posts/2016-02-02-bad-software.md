---
layout: post
title: UEFI and Windows 10
tags: computers software
---

My primary desktop environment is some variant of GNU/Linux.  The only case where this hasn't been true is
when I was really into PC gaming and was operating off of Windows 7 for that purpose.

Recently I've been more interested in privacy.  One nice thing you can do several modern GNU/Linux
distributions is full disk encryption (FDE).  I've been using this where possible for over two years now.
Unfortunately, FDE requires the GNU/Linux distro to completely take over your HDD.
For my purposes, I wanted to dual boot Windows and GNU/Linux and have each of them use FDE.  There are
many blog posts and articles that a quick internet search will reveal which give insight on how to accomplish
this; however I saw no success whatsoever.  The problem seems to be exacerbated by the switch to UEFI from
BIOS.  I've been able to install Windows 7 and Manjaro KDE side-by-side without encryption on UEFI, but
literally every other combination I've tried has had some major failure where I've been unable to access one
OS or the other.  Right now it looks like the only solution I have is to have both OSes unencrypted and
to modify Grub to chainload Windows.  For now I'm choosing which OS to boot from the UEFI boot menu.

**Choosing which OS to boot**<br/>
UEFI is terrible.<br/>
It sounds like UEFI introduces a lot of nice technical upgrades over legacy BIOS mode, but every single time
I've ever had to know that I'm dealing with UEFI it's been because there's a problem preventing me from
doing what I want to do.  The best thing I can say about legacy BIOS is that I didn't know anything about BIOS
and I didn't care.  I could do what I needed to do to dual-boot or replace my OS or whatever. UEFI completely
breaks this capabability of the computer to simply work.  Now I need to know what UEFI is and how UEFI works
in order to try and configure my computer how I want.  Even then it doesn't usually work; and a cursory
search seems to indicate that I'm not the only one who's encountered these problems.  To top it off, I've
technically found a workable solution for what I want (though both my logical volumes are now unencrypted...)
but I have to select which OS to boot from the UEFI boot menu.  To do this I can't use my regular keyboard
(A Kinesis Advantage) so I need to have a secondary keyboard plugged in.  This situation is full of so much
fail and is so obviously worse than where things were before.  Alas, such seems to be the way of things.

**Windows**<br/>
It's pretty cool to shit on Windows these days.  The web is cool, everybody does web development, and all web
developers use a unixy environment. (Likely some variant of Mac, though there are a few of us GNU/Linux
stalwarts kicking around.)  Windows is pretty awesome, though. I'm *not* a die-hard Windows guy, so I'm not
intimately familiar with how awesome Windows is (or, conversely, the extent to which it is awful), but there
are a few obvious things:

- Great backwards compatibility
- Awesome support
- Great documentation
- Everything basically works
- Excellent debugging tools

Again, very high level as I'm not a Windows user so I don't have an in-depth understanding of these things.
These are just the obvious bits that I *am* aware of.

Installing Windows 10 is awful.<br />
It is literally the most awful OS installation procedure I've ever gone through.<br/>
First of all, how do you get Windows 10?  Buy a CD?  Get a downloadable image?  Nope!  You need to buy a
new computer with it already installed, or upgrade from an older OS.  You literally cannot get an installable
image of Windows 10 for an old computer.<br/>
Okay, sure.  That's terrible, but let's go along with it.

I'll just install Windows 7 here and then get the Windows 10 installer and update.  No problem.. *This doesn't
work!*  I'm serious, you can't do that.  First you have to install every single update that you can.  In my
case this was over 117 required updates taking up over 1GB of bandwidth.  This is *required* before you can
install Windows 10.<br/>
Okay, that is seriously bad, but let's go along with it.

Okay, two updates simply fail over and over.  I also can't install all the updates at once for some reason,
so I select a subset and install those in one go.  I do about 30 at a time, and every single group requires a
full restart.<br/>This is really, really awful, but fine, whatever, we're pretty used to that by now.

Now I can install Windows 10, right?  Sure, let's run the installer.  Going... fine, screen, click through; okay, now
I have to insert a product key.  I don't have a Windows 10 product key, so I use my Windows 7 product key,
right?  I literally have no idea and there's no documentation on this that is anywhere obvious.  Let's try it.<br />
Nope.  Doesn't work.</br>
Okay, let's search and see what we can find.  Hmm. Looks like the Windows 7 product key should work fine.
You actually need to update your entire OS first before you try to install Windows 10, and then you won't be
prompted for a product key because Windows *knows* your already activated Windows OS that you're running and
will register that with your motherboard so you're automatically good to go.<br/>
Except that is clearly not happening.  I am very clearly being asked for a product key despite being as up to
date as I can be.  Okay, whatever, let's find some help.  Oh, look, a Youtube video that says to just use this
random product key to proceed.  Okay, that works.  Great.  Now Windows 10 is installing.  Awesome. It's
finished.  Okay, now let's just change the background because the default one is garish. Oh. Windows 10 isn't
activated. Hmm.  Okay, activate it.  Oh, I have to input a product key.  Okay...  Oh, Windows 10 doesn't accept
my Windows 7 product key.<br/>
**THIS IS LITERALLY SO AWESOME THAT MY MIND HAS BROKEN**.

So, I opened a support chat with Microsoft.  A customer support agent used remote desktop to troubleshoot things.
It looks like they mostly just enabled a bunch of services that I disabled when installing Windows 10 and that
essentially allowed Windows 10 to update fully and activate my key.  I'm sure I missed something there, but that's
certainly what it looked like.<br/>
Yes, it looked like during my Windows 10 install, *configuring Windows 10 to not automatically share all my data
with Microsoft* broke the installation completely.<br/>
This entire process is so broken. How did any of this get okayed?

Well, it seems like I might be in a position now to finish configuring my desktop.  It's only taken three days
so far.  The first step will be trying to get a bootable image out of Windows 10 in case things get screwed up
along the way to final configuration.  Wish me luck.
