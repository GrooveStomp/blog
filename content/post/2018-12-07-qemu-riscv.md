---
date: 2018-12-07
url: /2018/12/07/qemu-riscv/
title: "qemu and RISC-V"
tags: [qemu, emulation, riscv]
---

It's been a long time since I've posted here.  So what's up?

I've been working at Lendesk in a team lead / senior developer role and trying to pursue my interest in Go and Linux.
This has been a very tricky path to navigate as work has abandoned any pretense of plans to adopt Go and all work machines are MacOS.
Thankfully, I've been able to carve out some personal time to keep poking around in my area of interest.

I met up with my buddy Lucas for drinks the other day, and as we are wont to do, we discussed Linux, programming, security, privacy and other such things.  This got my mind running and eventually I remembered
RISC-V<sup><a href="#2018-12-07_ref1">1</a></sup>.

A while back I bought a System76 laptop.  Originally I had placed an order for a Purism Librem 15, but due to some miscommunication and problems with delivery, I wound up cancelling that order.  Luckily, right after I had placed the order, System76 announced that they were removing Intel's IME from all of their machines.
Management-engine-freedom is a great step, but it's not quite all the way to Libreboot support, or entirely open hardware.
RISC-V is entirely open hardware.  I'm a huge fan of this.

So, last night I decided that I want to try poking around in the RISC-V world and see what kind of damage I can do.
All I managed to do is boot Fedora Linux on a version of qemu built with RISC-V support.
The community has done a ton of work here and the process is very easy to get started with; just follow the docs at qemu.org<sup><a href="#2018-12-07_ref2">2</a></sup>.
I was hoping to start poking around with Go on RISC-V, but doing so requires a cross-compilation build as described on the riscv-go README<sup><a href="#2018-12-07_ref3">3</a></sup>.

I will hopefully follow up again with this sometime soon and post appropriate updates here.

----
#### Footnotes
<sub><sup id="2018-12-07_ref1">1</sup><a href="https://riscv.org/">RISC-V</a></sub><br />
<sub><sup id="2018-12-07_ref2">2</sup><a href="https://wiki.qemu.org/Documentation/Platforms/RISCV">qemu.org RISC-V</a></sub><br />
<sub><sup id="2018-12-07_ref3">3</sup><a href="https://github.com/riscv/riscv-go#quick-start">riscv-go README</a></sub><br />