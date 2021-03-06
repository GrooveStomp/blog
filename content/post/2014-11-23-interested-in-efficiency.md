---
date: 2014-11-23
url: /2014/11/23/interested-in-efficiency/
title: Interested in Efficiency
tags: [programming]
---

  [Casey Muratori](http://mollyrocket.com/casey/about.html) started [Handmade Hero](http://handmadehero.org/).  It's his project to teach C programming to beginners by building a game from scratch using the most minimal subset of operating system calls possible.  I've been attending as many of the live streams as I can, and the whole project fills me with excitement.  Earlier this year [Mike Acton](https://twitter.com/mike_acton) gave a talk at CppCon titled [Data Oriented Design and C++](https://www.youtube.com/watch?v=rX0ItVEVjHc). I watched this video and watched it again, and again and again.  There are too many good parts to repeat here, and each message is greatly enriched in the overall context of that talk anyway.  Both of these remind me of [Andre Lamothe's XGameStation](http://www.xgamestation.com/about_xgamestation.php) and all have inspired me to really think about my professional life and my experiences with web technologies.

  > In the time Joomla takes to produce a single, sparse page, Call of Duty renders 5 frames of photorealistic graphics.
  > - [@cmuratori](https://twitter.com/cmuratori/status/536675456087359489)

  Since I work in the web, and I've been enjoying and learning from videogames my whole life, I am very familiar with these kinds of scenarios.  Unfortunately, my professional experience with web technologies really does support a lackadaisical approach to software development. There are definitely adept developers out there and I have learned lots from a few of them, but the overall scene is almost completely devoid of rigor or discipline. Here are some fun examples:

  - [Javascript is the assembly language for the web](http://www.hanselman.com/blog/JavaScriptIsAssemblyLanguageForTheWebSematicMarkupIsDeadCleanVsMachinecodedHTML.aspx). ([Not even close](http://benchmarksgame.alioth.debian.org/u32/benchmark.php?test=all&lang=v8&lang2=gcc&data=u32))
  - [Text editor built out of a web browser](https://atom.io/)
  - [Rails is for the vast majority of web applications Fast Enough](http://www.joelonsoftware.com/items/2006/09/12.html)

  I think it's important that we pay attention to underyling hardware architecture and support projects that encourage this deep level of understanding.  Things like Handmade Hero and XGameStation.  It's not so much that we should be programming in ASM all the time, but it's important to understand what the software we build is actually doing.  Slow software has a negative impact on the world.  Whether it's affecting users by forcing them to wait, or by consuming more energy than is needed; slow software has real world consequences.  Even things that are taken for granted in web development - things like garbage collection - should be looked at with a very critical eye.  Yes, there are tradeoffs to consider. How much programmer time do you have versus application execution time?  But things are never so easy when viewed within the larger context within which they operate.  How do you deploy your application?  Do you need to install a custom package manager?  Do you need to install a runtime environment?  Do you simply copy an executable?  When you are deciding on what is more valuable, are you able to see all the pieces that fit into the whole picture?

  I still think it's very worthwhile to learn languages like Haskell, Common Lisp, Factor and whatever other language you want.  It's important to learn to think in different ways and to push your understanding.  Do that!  Do that every day!  And it's pretty exciting that lots of these newer languages, tools and frameworks allow new programmers to create. I think it's a huge win for everybody if everybody has the ability to create and build for their own peculiar needs.  Just keep an eye on effeciency. Measure your programs.
