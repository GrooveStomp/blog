---
date: 2019-12-11
url: /2019/12/11/zig-odin-choosing-new-language/
title: "Zig, Odin and Choosing a New Language"
tags: [programming, c-lang, zig-lang, odin-lang]
---

HandMadeSeattle (HMS) happened this year!

HandMadeCon (HMC) was renamed and it's more of a community-focused event lead by the
indefatiguable Abner Coimbre.  I was a little hesitant about going this year
since it was on hiatus since 2016 and there's a slight change in direction;
but I'm extremely happy with how it turned out.

I met a bunch of people, some old faces and lots of new faces.  Of particular
relevance to this blog post are two developers I got to hang out with; Andrew
Kelley, creator of [Zig](https://ziglang.org/), and Ginger Bill, creator of
[Odin](http://odin-lang.org/)

I've been aware of both Zig and Odin for a number of years now - Zig after
Andrew told me about it at HMC2016 and Odin which I discovered browsing the
Handmade Network forums and projects.  If you know me, you also know that I've
been thinking about programming languages for a _long_ time; trying many out and
trying to commit to a few languages that seem optimal for the kind of work I
want to do.  To that end, I largely settled on Go and C in the past; although
this was always an uneasy truce of sorts.  C is not great and Go has its own
issues; but they both seemed to be the least bad options available.

So what of these languages Zig and Odin?  Honestly, I'm not going to dive into
too much detail here - they both have a decent amount of introductory material
on their websites and active communities on Discord.  I recommend you investigate
both on your own.  What I will do here is describe how I evaluated them and what
my extremely superficial analysis is of them and what I'm deciding to do going
forward.

## Evaluation

Originally I planned to go back and rewrite my CHIP-8 emulator in both Zig and
Odin as a form of evaluation.  That hasn't happened yet, and honestly probably
won't; although I do plan to rewrite it in Zig for different reasons.  The
actual method of evaluation I used was more opportunistic than that.

It is December now, and every december there is a new set of challenges similar
to [Project Euler](https://projecteuler.net/) put out on [Advent of
Code](https://adventofcode.com/).  I did a few of the challenges last year and
when I realized they were happening again, I jumped at the chance.  This also
happened to perfectly coincide with completing graphics and input for my [NES
emulator](https://github.com/GrooveStomp/gsnes) during a coinciding drought of
NES Emulation videos from
[OneLoneCoder](https://www.youtube.com/watch?v=F8kx56OZQhg).

So, [I did three days](https://github.com/GrooveStomp/advent_of_code). I first
started doing C, Go, Odin, Rust and Zig; but by day three I got exhausted with
Rust and saw no real benefit in continuing with C since the whole point is
partially to replace C anyway.  I don't think I will continue with Advent of
Code - at least I will not obligate myself to do so; but I have done enough to
get initial impressions from Zig and Odin.

### Odin
I really like Odin.

Odin feels very similar to Go, which I also like.

Writing code in Odin feels natural and there are very few contortions required
to make things work.  It's a very pleasant language to use, and I decided that I
would like to use it going forward.

However...

### Zig
Zig is a really odd language.

Aesthetically it feels to me like an intersection of Rust, Javascript and C.  I
don't like the naming style compared with Go or even Odin.

But, you know what?  It really effing works.

I was impressed with Zig going into HMS this year having read about how far it's
come, and I'm even more impressed now.

Just look at this list of [supported targets](https://ziglang.org/#Wide-range-of-targets-supported).

At HMS Andrew built a baremetal executable on the spot to run on some real
RISC-V hardware that was available at the show! (Unfortunately he didn't
actually get to try the baremetal demo out on that hardware...)

Zig has a robust [build system](https://ziglang.org/#Zig-Build-System).

Zig can be considered to be [a better C compiler than C](https://ziglang.org/#Zig-ships-with-libc).

Zig has robust support for [cross compilation](https://ziglang.org/#Cross-compiling-is-a-first-class-use-case).

Honestly, the tooling support and platform support for Zig is what completely
sold me on the language.

A short while ago - just after starting on my Gameboy emulator, I decided that
I'd like to write a Gameboy Advance game.  While playing with Zig lately a [GBA
Hello World in Zig](https://github.com/wendigojaeger/ZigGBAHelloWorld/) popped
up!

Honestly, it's like the stars have aligned or something.

## Next Steps

I really like Odin, but Zig seems to be so much more robust at this point.  Bill
says Odin is a stable language, and maybe it is more stable than Zig; but the
entire ecosystem appears to paint a different picture - at least in my eyes.

That doesn't mean I've given up on Odin though!

I'm very interested in contributing in any way possible to Odin.  I strongly
believe that Odin can make it to where Zig is right now; and potentially even
surpass it.  I want to play a part in bringing that vision to fruition; provided
it matches what Bill is trying to do with Odin.

Everything else being equal, I would rather program in Odin than in Zig.  Not
that I think Zig is a bad language - I just prefer the aesthetics of Odin and
how natural it felt to program in it.

In the meantime, I will be using Zig for my personal projects.