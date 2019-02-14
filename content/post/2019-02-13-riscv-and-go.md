---
date: 2019-02-13
url: /2019/02/13/riscv-go-qemu/
title: "RISC-V, Go and QEMU"
tags: [qemu, emulation, riscv, golang]
---
I finally took the opportunity to jump back into RISC-V, Go and QEMU as a followup to my previous exploration.<sup><a href="#2019-02-13_ref1">1</a></sup>

I had a difficult time understanding exactly what was required to run my compiled Go program in QEMU.
Let's take a look at the instructions.<sup><a href="#2019-02-13_ref2">2</a></sup>

> Compile and run in qemu-riscv64 (which is expected to be in PATH):
>
    $ GOARCH=riscv GOOS=linux go run ../riscvtest/add.go
>
> Build:
>
    $ GOARCH=riscv GOOS=linux go build ../riscvtest/add.go

I was confused by was the mention of `qemu-riscv64` being in `PATH`.

The qemu-riscv instructions I followed<sup><a href="#2019-02-13_ref3">3</a></sup> didn't make any particular mention of a standalone `qemu-riscv64` executable, and there's all those parameters for block devices and whatnot.

Well, if I just take a look at my riscv-qemu dir:

```
↳ ls | grep riscv
riscv32-linux-user
riscv32-linux-user-config-devices.mak.d
riscv32-softmmu
riscv32-softmmu-config-devices.mak.d
riscv64-linux-user
riscv64-linux-user-config-devices.mak.d
riscv64-softmmu
riscv64-softmmu-config-devices.mak.d
```

Aha! Something!

In fact, there is exactly a `qemu-riscv64` executable:
```
↳ find . -name 'qemu-riscv64'
./riscv64-linux-user/qemu-riscv64
```

So now it's a piece of cake to run the RISC-V executable built from Go:
```
↳ pwd
/home/aaron/code/riscv-go/src

↳ GOARCH=riscv GOOS=linux go build ../riscvtest/add.go

↳ ~/code/riscv-qemu/riscv64-linux-user/qemu-riscv64 ./add
Aaron: 12

↳ echo $?
12
```
I modified the program to print out like that because I didn't know offhand how to check the exit status of an executable. Turns out you just `echo $?` and it works!

But that's not all. It wasn't at all clear to me what was going on, so I started doing some searching and stumbled upon this<sup><a href="#2019-02-13_ref4">4</a></sup> explanatory post:

> There are three families of targets in QEMU:
>
>   User-mode emulation, where QEMU provides an AEE (Application Execution Environment). In this mode, QEMU itself acts as the supervisor -- in other words, when QEMU sees an ecall it will decode the syscall number/arguments, perform the system call, and then return to emulating instructions. QEMU's user-mode emulation is thus tied to a specific supervisor's ABI, with the only instance I've seen in RISC-V land being Linux.
>
>   Soft MMU, where QEMU provides an MEE (Machine Execution Environment). In this mode the entire software stack is run as if it was running on a full RISC-V system with QEMU providing emulated devices -- in other words, when QEMU sees an ecall it will start emulating code at the trap vector. Here QEMU doesn't need to know anything about the supervisor as the exact supervisor code is running.
>
>   Hardware virtualization, where QEMU provides a HEE (Hypervisor Execution Environment) while relying on hardware emulation to provide better performance. We don't have this working on RISC-V yet (as of October 2018), but there are specifications in progress along with early implementation work.
>
> If you see ecall instructions in userspace just magicly working, then you're probably running in user-mode emulation.

Ah, very interesting!

That led me nearly directly to sections 3<sup><a href="#2019-02-13_ref5">5</a></sup>, 4<sup><a href="#2019-02-13_ref6">6</a></sup> and 5<sup><a href="#2019-02-13_ref7">7</a></sup> of the QEMU documentation, covering that StackOverflow post.
Section 5, directly led me to finally understanding how to run my Go program built for RISC-V architecture.

So this is very interesting to me. As I understand it, QEMU is running in "user space emulator" mode, acting as the operating system, implementing system calls.
It seems like the riscv-go page even mentions this<sup><a href="#2019-02-13_ref8">8</a></sup>:

> Spike plus pk support only a small subset of Linux syscalls and will not be capable of supporting the full Go runtime.
>
> The RISC-V QEMU port supports a much wider set of syscalls with its "User Mode Simulation". See Method 2 in the QEMU README for instructions.

However, I'll be honest: I don't know what "Spike plus pk" is, so I essentially just ignored that part on first read.

Unfortunately, it seems like this is a long ways from running a native Go executable on simulated RISC-V hardware.  I think. I'm honestly not super clear on System Emulator mode vs. Guest Agent mode vs. User Space Emulator mode yet.  I have a vague understanding but will need to explore more.
I think running the Fedora image as I did before is closer to running a "true" RISC-V system.

Here's the command:

```
qemu-system-riscv64 \
   -nographic \
   -machine virt \
   -smp 4 \
   -m 2G \
   -kernel bbl \
   -object rng-random,filename=/dev/urandom,id=rng0 \
   -device virtio-rng-device,rng=rng0 \
   -append "console=ttyS0 ro root=/dev/vda" \
   -device virtio-blk-device,drive=hd0 \
   -drive file=stage4-disk.img,format=raw,id=hd0 \
   -device virtio-net-device,netdev=usernet \
   -netdev user,id=usernet,hostfwd=tcp::10000-:22
```
So it's running in System Emulator mode (I'm guessing, based on the executable invocation) which should be as close as we can get.

Hopefully I can put some more time into better understanding this stuff.  It's been interesting!

----
#### Footnotes
<sub><sup id="2019-02-13_ref1">1</sup><a href="/2018/12/07/qemu-riscv/">QEMU and RISC-V</a></sub><br />
<sub><sup id="2019-02-13_ref2">2</sup><a href="https://github.com/riscv/riscv-go#quick-start">riscv-go Quick Start</a></sub><br />
<sub><sup id="2019-02-13_ref3">3</sup><a href="https://wiki.qemu.org/Documentation/Platforms/RISCV">qemu-riscv Wiki</a></sub><br />
<sub><sup id="2019-02-13_ref4">4</sup><a href="https://stackoverflow.com/a/52807871">QEMU targets</a></sub><br />
<sub><sup id="2019-02-13_ref5">5</sup><a href="https://qemu.weilnetz.de/doc/qemu-doc.html#QEMU-System-emulator-for-non-PC-targets">QEMU System Emulator</a></sub><br />
<sub><sup id="2019-02-13_ref6">6</sup><a href="https://qemu.weilnetz.de/doc/qemu-doc.html#QEMU-Guest-Agent">QEMU Guest Agent</a></sub><br />
<sub><sup id="2019-02-13_ref7">7</sup><a href="https://qemu.weilnetz.de/doc/qemu-doc.html#QEMU-User-space-emulator">QEMU User Space Emulator</a></sub><br />
<sub><sup id="2019-02-13_ref8">8</sup><a href="https://github.com/riscv/riscv-go#qemu">riscv-go QEMU</a></sub><br />