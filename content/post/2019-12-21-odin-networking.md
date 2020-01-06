---
date: 2019-12-21
url: /2019/12/21/odin-networking/
title: "Odin Lang Networking"
tags: [programming, c-lang, odin-lang, sockets, http, networking]
---

In today's post I want to explore Odin's C FFI.

As of today, Odin does not have a core networking library; something I consider to be an impediment to productivity.

I'll start with a simple C program using BSD sockets for network communication, then look at Odin's FFI mechanism, finally implementing a simple network program in Odin using HTTP.

# BSD Sockets

I've [used BSD sockets before](https://github.com/GrooveStomp/practice/tree/master/2016/01/11) but only in a hobbyist capacity; nothing production worthy. So my knowledge of sockets is superficial. Thankfully the documentation is fairly robust.

Documentation for socket programming is pretty easy to find. I leaned heavily on [man7.org](http://man7.org/linux/man-pages/man7/socket.7.html).

The socket interface defines several functions, structures and values, but I'm only concerned with a very small subset for the purposes of this program.
I'll narrow the discussion to:

- [socket()](http://man7.org/linux/man-pages/man2/socket.2.html)
- [connect()](http://man7.org/linux/man-pages/man2/connect.2.html)
- [struct sockaddr](http://man7.org/linux/man-pages/man2/bind.2.html)
- [struct sockaddr_in](http://man7.org/linux/man-pages/man7/ip.7.html)
- [struct in_addr](http://man7.org/linux/man-pages/man7/ip.7.html)

And for reading and writing we can rely on standard [read()](http://man7.org/linux/man-pages/man2/read.2.html) and [write()](http://man7.org/linux/man-pages/man2/write.2.html) calls since the socket interface provides us with os filehandles.

The 50,000ft view of this is:

1. Use `socket()` to create a new socket and get the filehandle.
2. Fill out data in `struct sockaddr_in` and pass this with the filhandle to `connect()`.
3. Use `write()` to write data to the socket.
4. Use `read()` to read data from the socket.

That's it!

## Sample C Program

Here's a very simple C program to illustrate usage in practice:

```
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <stdint.h>

int main() {
        char buffer[BUFSIZ+1];

        register int s;
        if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
                perror("socket");
                return 1;
        }
        printf("Have socket\n");

        struct sockaddr_in sa;
        bzero(&sa, sizeof sa);

        sa.sin_family = AF_INET;
        sa.sin_port = htons(80);
        sa.sin_addr.s_addr = htonl((172 << 24) | (217 << 16) | (3 << 8) | (195 << 0));

        if (connect(s, (struct sockaddr *)&sa, sizeof sa) < 0) {
                perror("connect");
                close(s);
                return 2;
        }
        printf("Connected\n");

        char *text =
                "GET / HTTP/1.1\r\n"
                "Accept: */*\r\n"
                "User-Agent: curl\r\n"
                "\r\n";

        register int bytes;
        if ((bytes = send(s, text, strlen(text), 0)) < 0) {
                perror("send");
                close(s);
                return 1;
        }

        while ((bytes = read(s, buffer, BUFSIZ)) > 0)
                write(1, buffer, bytes);

        close(s);
        return 0;
}
```

# Odin FFI

Odin has a [foreign system](http://odin-lang.org/docs/overview/#foreign-system) for interfacing with C that is actually very nice to use in practice.  The documentation is a little sparse so far, but there are some decent examples to learn form if you look.

This is not a comprehensive guide to FFI in Odin; rather an exposure to the parts that are necessary for the demonstration program.

## Foreign Import
The first part is importing a C (foreign) library, which we do very similarly to regular imports in Odin:

```
foreign import libc "system:c"
```

We import the C standard library here and namespace it to `libc` for subsequent usage.

## Foreign Block
We can define external lookup. I'm not if this works for structures and data; but it certainly works for functions and that's what we care about here.

```
foreign libc {
    @(link_name="socket") _unix_sock_socket :: proc(domain: i32, type: i32, protocol: i32) -> i32 ---;
}
```
Note the `---` body syntax for defining an external function.

We can use the `link_name` attribute to specify the name the function is defined with, then we define our own local function `_unix_sock_socket` for use within our codebase. The latter name escapes the foreign block for use within application code without needing the `libc` namespace prefix.

## Function Wrapping

The final piece is to wrap external functions with more idiomatic Odin code:

```
socket :: proc() -> (os.Handle, os.Errno) {
    result := _unix_sock_socket(i32(2), i16(1), 0); // Magic numbers should be in an enumeration.
    if result == -1 {
        return -1, os.Errno(os.get_last_error());
    }
    return os.Handle(result), os.ERROR_NONE;
}
```

# Odin code

So we've now been exposed to all the basic components we need to make this work in Odin.

It's a fairly straightforward translation from the C header files to the `foreign libc` block function declarations.

Here's the final sample code to illustrate:

```
package main

import "core:fmt"
import "core:c"
import "core:os"
import "core:strings"
import "core:mem"

foreign import libc "system:c"

INET: i16 : 2;
STREAM: i32 : 1;

Sockaddr_In :: struct {
    family: i16,
    port:   u16,
    addr:   In_Addr,
    _:      [8]u8, // 14 bytes of protocol address
}

In_Addr :: struct {
    addr: u32,
}

Sockaddr :: struct {
    family: u16,
    data: [14]u8,
}

@(default_calling_convention="c")
foreign libc {
    htonl :: proc(hostlong: u32) -> u32 ---;
    htons :: proc(hostshort: u16) -> u16 ---;
    @(link_name="socket")    _unix_sock_socket  :: proc(domain: i32, type: i32, protocol: i32) -> i32 ---;
    @(link_name="connect")   _unix_sock_connect :: proc(fd: i32, addr: ^Sockaddr, addrlen: u32) -> i32 ---;
    @(link_name="send")      _unix_sock_send    :: proc(fd: i32, msg: ^u8, msg_len: i32, flags: i32) -> i32 ---;
    @(link_name="inet_pton") _unix_sock_pton    :: proc(domain: i32, ip: ^u8, addr: ^In_Addr) -> i32 ---;
}

pton :: proc(ip: []byte, addr: ^In_Addr) -> os.Errno {
    result := _unix_sock_pton(i32(INET), &ip[0], addr);
    if result == -1 {
        return os.Errno(os.get_last_error());
    }
    return os.ERROR_NONE;
}

socket :: proc() -> (os.Handle, os.Errno) {
    result := _unix_sock_socket(i32(INET), STREAM, 0);
    if result == -1 {
        return -1, os.Errno(os.get_last_error());
    }
    return os.Handle(result), os.ERROR_NONE;
}

connect :: proc(fd: os.Handle, addr: ^Sockaddr_In) -> os.Errno {
    result := _unix_sock_connect(i32(fd), cast(^Sockaddr)addr, size_of(Sockaddr_In));
    if result == -1 {
        return os.Errno(os.get_last_error());
    }
    return os.ERROR_NONE;
}

send :: proc(fd: os.Handle, msg: []byte) -> (int, os.Errno) {
    result := _unix_sock_send(i32(fd), &msg[0], i32(len(msg)), 0);
    if result == -1 {
        return -1, os.Errno(os.get_last_error());
    }
    return int(result), os.ERROR_NONE;
}

main :: proc() {
    fmt.println("Creating socket...");
    client, err := socket();
    if err != os.ERROR_NONE {
        fmt.printf("Socket open error: %v\n", err);
        return;
    }
    defer os.close(client);
    fmt.printf("Socket created! %v\n", client);

    host_addr: Sockaddr_In;
    host_addr.family = INET;
    host_addr.port = u16(htons(80));
    ip := "172.217.3.195"; // www.google.ca
    pton(transmute([]byte)ip, &host_addr.addr);

    fmt.printf("Connecting...\n");
    err = connect(client, &host_addr);
    if err != os.ERROR_NONE {
        fmt.printf("Socket connect error: %v\n", err);
        return;
    }
    fmt.printf("Connected!\n");

    fmt.printf("Sending...\n");
    msg := "GET / HTTP/1.1\r\nAccept: */*\r\nHost: www.google.ca\r\nUser-Agent: curl/7.65.3\r\n\r\n";
    byte_msg := transmute([]byte)msg;

    bytes: int;
    bytes, err = os.write(client, byte_msg);
    if err != os.ERROR_NONE {
        fmt.printf("Socket connect error: %v\n", err);
        return;
    }
    fmt.printf("Bytes sent: %v\n", bytes);

    buf: [1]u8;
    for {
        bytes, err = os.read(client, buf[:]);
        if err != os.ERROR_NONE {
            fmt.printf("Some error!\n");
            break;
        }
        if bytes == 0 {
            fmt.printf("No bytes read!\n");
            break;
        }
        fmt.printf("%v", rune(buf[0]));
    }
}
```

# Problems

As is typical of these kinds of things, this did not go smoothly.

I had a few hiccups, but one _major_ hiccup that held me up for a while.
The way this problem manifested is that I couldn't complete a socket connection.  Originally I was getting error 111.  (Note that [Odin encodes all OS error codes](https://github.com/odin-lang/Odin/blob/master/core/os/os_linux.odin).)
111 is *ECONNREFUSED*.  After asking on the official Discord and going over the documentation with a fine-toothed comb, I kept altering the data structures and FFI declarations, but to no real avail.  Eventually the error code stopped getting returned and the program just died; then I was faced with a consistent 22: *EINVAL*.
How do I fix that?

How _do_ you fix an error like that?

I compared the Odin source with my working C source and it honestly looked too similar. I printed out the structure contents in the C source and Odin source and they looked _identical_; so what could be going wrong?

I took a break and kept thinking about it in the back of my mind.  It occurred to me that there must be something different with the data.  If I'm making the system call to connect and getting a response, then the FFI binding must be good, so let's start there!

But how do I compare the data?

Easy!

Let's reinterpret cast ("transmute" in Odin parlance) the structures to streams of bytes and compare each byte!

This is how you do that in C:

```
char *recast = (char *)&sa;
for (int i = 0; i < sizeof(sa); i++) {
        printf("0x%02X ", (uint8_t)recast[i]);
        if ((i + 1) % 4 == 0) {
                printf("\n");
        }
}
```

And in Odin:
```
ptr: ^byte = transmute(^byte)&host_addr;
for i := 0; i < size_of(host_addr); i+=1 {
    offset := mem.ptr_offset(ptr, i);
    fmt.printf("0x%02X ", offset^);
    if (i + 1) % 4 == 0 {
        fmt.println();
    }
}
```

The output looks like t his:
```
0x02 0x00 0x00 0x50
0xAC 0xD9 0x03 0xC3
0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00
```

At this point it was a matter of printing that data out in several locations to see if it was correct.

Here's where I learned two things:

1. BSD Sockets are supremely old and predate using `void *` as a mechanism for passing polymorphic data.
   `struct sockaddr` is a "base" structure that all kinds of `sockaddr`s get cast to in the socket API.

    This is interesting, but wasn't actually an issue in my program.

2. The data was different!

The culprit I had was in the definition of `connect`:
```
connect :: proc(fd: os.Handle, addr: ^Sockaddr_In) -> os.Errno {
    result := _unix_sock_connect(i32(fd), cast(^Sockaddr)addr, size_of(Sockaddr_In));
    if result == -1 {
        return os.Errno(os.get_last_error());
    }
    return os.ERROR_NONE;
}
```

That's the working version. The incorrect version had this line instead:
```
    result := _unix_sock_connect(i32(fd), cast(^Sockaddr)addr, size_of(addr));
```

Something which seems supremely obvious to me now because `addr` is a pointer and not a structure.
Oh well!  It wasn't only my eyes that missed it. :-)

And that concludes this very brief, exploratory look at C FFI in Odin.