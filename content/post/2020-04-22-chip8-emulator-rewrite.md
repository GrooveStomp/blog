---
date: 2020-04-22
url: /2020/04/22/chpi8-emulator-rewrite/
title: ""
tags: [programming, zig-lang, chip-8, emulation]
---

- Wanted to write a gameboy emulator
- Had no idea how to write an emulator
- Heard about CHIP-8
- Wrote CHIP-8 emulator https://www.groovestomp.com/chip8/html/index.html
  - Made several assumptions...
  - Nasty multithreading code
  - Otherwise, success!

- About that gameboy emulator...
- Oh look! NES Emulator series on Youtube.
- Did that! https://github.com/GrooveStomp/gsnes

[Previously](/2019/12/11/zig-odin-choosing-new-language/) I expressed interest in doing my hobby programming in Zig.
- Let's apply learning from NES to CHIP-8
- Here you go: https://github.com/GrooveStomp/chip8-zig