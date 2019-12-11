---
title: Projects
type: page
---
- [NES Emulator](https://github.com/GrooveStomp/gsnes)<br/>
  NES Emulator written in C11.

- [CHIP-8 Emulator](https://groovestomp.github.io/chip8/html/index.html)<br/>
  A basic CHIP-8 emulator written from scratch with a built in graphical debugger, written in C11.

- [3D Software Renderer](https://github.com/GrooveStomp/3dsw)<br/>
  This is my latest realtime 3D software renderer, based off of the work done by [OneLoneCoder / javidx9](https://onelonecoder.com/).
  It's not an exact copy as it's written in C11 instead of C++11.
  I have written a few software renderers, now:<br/>
  - [Tiny Renderer](https://github.com/GrooveStomp/tiny-renderer)<br/>
    An offline renderer I wrote in Go, partially to learn Go, based off the project of the same name, linked in the repo.
  - [Software Renderer](https://github.com/GrooveStomp/software-renderer)</br>
    A "clean room" realtime implementation with only mathematical resources to work from.
  - [Raytracer](https://github.com/GrooveStomp/raytracer/tree/master/in_one_weekend)<br/>
    An offline implementation based off of the book mentioned in the repo.

- [GameBoy Emulator](https://github.com/GrooveStomp/gsgb)<br/>
  A Nintendo GameBoy emulator I am in the process of writing.<br/>
  Temporarily on hold.<br/>
  Started in C++11, but will be re-written in Zig.

- [C Parser](https://github.com/GrooveStomp/cparser)<br/>
  HandmadeHero and The Jeff and Casey Show motivated me to start exploring
  making my own language and development tools.  This is the first bit of that
  exploration.  I decided to start designing a new language based on a
  foundation of C.  This is my hand-written recursive-descent parser written in
  C. Currently it only builds a debug parse tree and outputs that in the
  terminal.  There is no code generation.

- [Personal C Library](https://github.com/GrooveStomp/gslibc)<br/>
  I started doing a lot more hobby programming in C.  C has a really weak
  standard library, so you always end up rolling your own.  This is intended to
  be along the lines of [gingerBill's
  libraries](https://github.com/gingerBill/gb) or the [stb
  libraries](https://github.com/nothings/stb).

- [Config-file Precompiler](https://github.com/GrooveStomp/gscfg)<br/>
  For one project I really wanted to have a yaml-style configuration file but
  not have to do dynamic memory allocations or runtime parsing of the config
  file to use the data.  My solution was to build a precompiler which generates
  a .c file for inclusion into your source tree.

See more at [GitHub](https://github.com/GrooveStomp).
