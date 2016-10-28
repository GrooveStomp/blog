---
layout: post
title: An Update On Self-Hosting Progress
tags: self-hosting
---

Well, it seems I'm making very slow progress towards my goal of self-hosting.  The first issue I've run into
is with officially support OSes.  I like running Arch Linux, but Arch Linux is not officially supported by either
OwnCloud or GitLab.  GitLab is the more demanding of the two applications, requiring a minimum of 2GB of RAM
and strongly recommending 2 cores.  Unfortunately, I have Manjaro (an Arch distribution) running on my Dell
Mini 10 where I installed GitLab via Yaourt; but that machine only has 1GB of RAM and a single core.  Luckily,
my Acer Aspire One D270 has 2 cores and 2GB of RAM, and I just finished installing CentOS 7 on there the
other day. I'll see if I can get GitLab running on it.  The GitLab installation instructions are not at all
breezy, though; so we'll see how far I make it this week.  In the meantime, I'll continue searching for a
Debian 7 or CentOS 6.5 image for the 32bit Dell Mini 10 so I can start installing OwnCloud on that.