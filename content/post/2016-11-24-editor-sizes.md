---
date: 2016-11-24
title: Editor Sizes
tags: [editors, text editors, memory size, memory, size]
---

A few months ago I was starting to get irked at the relatively poor performance of Emacs on my primary development system.
Emacs isn't terrible, but it is noticeably slow compared to Vim. So, for the sake of curiosity I decided to look at some executable sizes.
I started by just doing a simple:
```Bash
ls -alh `which <editor>`
```
But that only captures the size of the executable on disk without regard for any shared libraries or dynamic memory allocations.

I can't recall where, but I found a comment on some forum that suggests the following:
```Bash
ps -Ao rsz,vsz,cmd | grep <editor>
```
This works well.  `rsz` and `vsz` are Resident Size and Virtual Size, respectively.  `cmd` gives the name of the executable.
Output looks like this:
```Bash
$ ps -Ao rsz,vsz,cmd | grep [s]t
8896  65592 /usr/local/bin/st
```
The resident size is how much memory is actually in use by the application and the virtual size is how much memory the application has requested.
There's usually a rather large delta there, and it's kind of interesting to see.  In both cases the size is given in bytes, so divide by 1024 to get Kibibytes and by 1048576 to get Mebibytes. (Kilobytes and Megabytes in common terminology.)
I did an audit of various text editors running in terminal or gui mode and captured their resident memory sizes which I'm sharing below.
Pay attention to the suffix because there are many orders of magnitude differences between the smallest and largest programs!

In no particular order:

|Editor Name|Resident Memory Size|GUI or TUI|Additional Information|
|-----------|--------------------|----------|----------------------|
|emacs|57.99 MB|GUI|No local settings files|
|emacs|22.43 MB|TUI|With local settings files|
|emacs|12.77 MB|TUI|No local settings files|
|nano|1.77 MB|TUI||
|uemacs/pk|916 KB|TUI|https://github.com/snaewe/uemacs|
|jed|1.6 MB|TUI||
|gvim|25.8 MB|GUI||
|vim|25.8 MB|TUI||
|atom|266 MB|GUI||
|nice|1 MB|TUI|http://ne.di.unimi.it/|
|micro|10.95 MB|TUI|https://github.com/zyedidia/micro|
|vis|3.88 MB|TUI|https://github.com/martanne/vis|
|TextAdept|25.58 MB|GUI||
|TextAdept|6.58 MB|TUI||
|jupp|3.37 MB|TUI|https://www.mirbsd.org/jupp.htm|
|mg|1.03 KB|TUI|Micro GNU/emacs, this is a portable version of the mg maintained by the OpenBSD team.|

NOTE: TUI means Textual UI and you'll often see "curses", "cli", "console" or "terminal" used to mean the same thing.

Don't take these records as gospel; I've noticed differences on subsequent captures of various programs.  Without a doubt each editor will perform differently depending on the specific file and how the editor represents said file in memory.  Also, I generally don't have a good understanding of Linux memory, so there are lots of ways these numbers could be non-representative.  As a ballpark estimate, however, I suspect these numbers should suffice. 

If you liked this, you might enjoy [A Memory Comparison of Light Linux Desktops](https://l3net.wordpress.com/2013/03/17/a-memory-comparison-of-light-linux-desktops/)
