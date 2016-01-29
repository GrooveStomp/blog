---
layout: post
title: Self Hosting
tags: self-hosting
---

I'm going to start this post with a little problem I created for myself.

# So many computers
Let's see here. I have a gaming desktop at home, a work laptop at work, a
netbook at home for resource-constrained programming and a Raspberry Pi.
That's cool.  Daniela also has her own computer, but that's hers and I simply
leave it be.
Two weeks ago I caught myself watching The 8-Bit Guy talking about the Macbook
Core Duo and seeing if it's obsolete<sup><a href="#2016-01-25_ref1">1</a></sup>. I was really impressed by
how capable the machine still is, and also had the Libreboot project sitting
in the back of my mind.  Specifically, Libreboot mentions 2008 and earlier Intel
chips possibly being okay...  So that's arriving on Thursday, presumably.
Oh, and I just bought another netbook off of a coworker.

Maybe, just maybe I have a problem.

Did I happen to mention that I'm looking to get a replica Altair 8800, too?<sup><a href="#2016-01-25_ref2">2</a></sup>

## Power Usage
Okay, time for a little tangent.

One interesting thing about all these different computers is how much power
they draw and what they can be used for.
Initially I picked up my first netbook for resource-constrained programming,
thinking I could do some software rendering optimizations on it.  As my
collection of computers has grown, my goals for each machine have changed.
I now envision an army of servers aided by a couple of special purpose machines.
Well, maybe not an army, but definitely two servers (each netbook) plus hooking
up my Raspberry Pi as a torrent machine.  My desktop will change once again
to a hybrid gaming/programming machine - granted I can ever wrangle UEFI dual
boot with full disk encryption; and my work machine will remain as-is.

I think the netbooks are great as potential servers because they have pretty
low power draw compared to my mammoth desktop.  According to some quick searches
and rough calculations, I'm looking at power draws of 10-22W, 45W and 3.5W
respectively, for each of my Dell Mini 10 (netbook 1), Acer Aspire One
(netbook 2) and Raspberry Pi.  Compare that with my 500+W desktop with a power
supply so large that I know it's more than 500W, I just can't remember how much
more.

# Privacy
The new Macbook is interesting.  It is apparently supported by Libreboot.<sup><a href="#2016-01-25_ref3">3</a></sup>
I actually didn't realize this before splurging on it, but it has turned out
to be a happy coincidence.  I mean, I did have suspicions it would work out...
But why do I care about Libreboot? Have you heard about Intel's Management Engine?<sup><a href="#2016-01-25_ref4">4</a></sup>&nbsp;<sup><a href="#2016-01-25_ref5">5</a></sup>
Or how about AMD's PSP?<sup><a href="#2016-01-25_ref6">6</a></sup>
Basically, we're all screwed.  As my good friend Lucas says, "Encrypt Everything."<sup><a href="#2016-01-25_ref7">7</a></sup>
At work I've already configured DNSCrypt, and you may have noticed that my
website is also served via HTTPS now.  This is all part of the big plan.

# Self Hosting
Right now I host my website via GitHub pages.  I also host all my code
projects on BitBucket and GitHub.  I have photos up on SmugMug and I stream
videos from Netflix.  That last one will probably remain, but I will definitely
change the others.

Here's the plan:
My brother recently brought to my attention that my router is supported by
OpenWRT<sup><a href="#2016-01-25_ref8">8</a></sup>. Great!

&nbsp;&nbsp;<b>1</b>: Install OpenWRT onto router<br />
&nbsp;&nbsp;<b>2</b>: Install OpenVPN<sup><a href="#2016-01-25_ref9">9</a></sup> onto router<br />
&nbsp;&nbsp;<b>3</b>: Install DNSCrypt<sup><a href="#2016-01-25_ref10">10</a></sup> onto router

That'll set up my home environment so all of our locally networked devices have
a secure, private connection out to the wide internet.
Now, remember all my netbooks?  Yeah, those fit nicely into the plan.

&nbsp;&nbsp;<b>4</b>: Setup OwnCloud<sup><a href="#2016-01-25_ref11">11</a></sup> on netbook 2<br />
&nbsp;&nbsp;<b>5</b>: Self-host my website on netbook 1<br />
&nbsp;&nbsp;<b>6</b>: Host code projects via GitLab<sup><a href="#2016-01-25_ref12">12</a></sup> on netbook 1

The final piece will be hacking together a gateway so my webserver is accessible
publicly.  I may use this solution to cover my OwnCloud server as well.

&nbsp;&nbsp;<b>7</b>: Get a small VPS instance for $5 USD/mo. from Digital Ocean<sup><a href="#2016-01-25_ref13">13</a></sup><br />
&nbsp;&nbsp;<b>8</b>: Setup SSL keys between my VPS and home machine(s) via Let's Encrypt<sup><a href="#2016-01-25_ref14">14</a></sup><br />
&nbsp;&nbsp;<b>9</b>: Forward appropriate requests from my VPS to my home machines via some wizardry

Well, that's the plan anyway.
Oh, I intend to self-host email as well.  But, I believe that option is rife
with complexities, and I'm reasonably happy with ProtonMail<sup><a href="#2016-01-25_ref15">15</a></sup> so far.

<b>PS</b>: I pay Private Internet Access for access to their non-logging VPN.<sup><a href="#2016-01-25_ref16">16</a></sup>

----

#### Footnotes

<sub><sup id="2016-01-25_ref1">1</sup><a href="https://www.youtube.com/watch?v=FJw8aSxEFwQ">The 8-Bit Guy: Is It Obsolete?</a></sub><br />
<sub><sup id="2016-01-25_ref2">2</sup><a href="http://www.brielcomputers.com/wordpress/?cat=18">Briel Computers Altair 8800 Micro</a></sub><br />
<sub><sup id="2016-01-25_ref3">3</sup><a href="https://libreboot.org/docs/hcl/index.html#macbook21">Libreboot: Macbook 2,1</a></sub><br />
<sub><sup id="2016-01-25_ref4">4</sup><a href="https://hackaday.com/2016/01/22/the-trouble-with-intels-management-engine/">Hackaday: The Trouble With Intel's Management Engine</a></sub><br />
<sub><sup id="2016-01-25_ref5">5</sup><a href="https://libreboot.org/faq/#intelme">Libreboot: Intel ME</a></sub><br />
<sub><sup id="2016-01-25_ref6">6</sup><a href="https://libreboot.org/faq/#amd">Libreboot: AMD PSP</a></sub><br />
<sub><sup id="2016-01-25_ref7">7</sup><a href="https://www.lucasamorim.ca/2016/01/16/encrypt-everything.html">Lucas Amorim: Encrypt Everything</a></sub><br />
<sub><sup id="2016-01-25_ref8">8</sup><a href="https://openwrt.org/">OpenWRT</a></sub><br />
<sub><sup id="2016-01-25_ref9">9</sup><a href="https://wiki.openwrt.org/doc/howto/vpn.openvpn">OpenVPN on OpenWRT</a></sub><br />
<sub><sup id="2016-01-25_ref10">10</sup><a href="https://wiki.openwrt.org/inbox/dnscrypt">DNSCrypt on OpenWRT</a></sub><br />
<sub><sup id="2016-01-25_ref11">11</sup><a href="https://owncloud.org/">OwnCloud</a></sub><br />
<sub><sup id="2016-01-25_ref12">12</sup><a href="https://about.gitlab.com/">GitLab</a></sub><br />
<sub><sup id="2016-01-25_ref13">13</sup><a href="https://www.digitalocean.com/pricing/">Digital Ocean</a></sub><br />
<sub><sup id="2016-01-25_ref14">14</sup><a href="https://letsencrypt.org/">Let's Encrypt</a></sub><br />
<sub><sup id="2016-01-25_ref15">15</sup><a href="https://protonmail.com/">ProtonMail</a></sub><br />
<sub><sup id="2016-01-25_ref16">16</sup><a href="https://www.privateinternetaccess.com/">Private Internet Access</a></sub><br />
