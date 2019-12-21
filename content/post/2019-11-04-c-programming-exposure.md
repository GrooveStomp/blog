---
date: 2019-11-04
url: /2019/11/04/c-programming-exposure/
title: "C Programming Exposure"
tags: [programming, c-lang]
---

# Introduction
I started programming in C relatively recently; about 2016.  Prior to this I had
a fair amount of exposure to C++ through university, and through my first job at
Electronic Arts.  I am one of those people who would write "C/C++" because I
knew enough C to make my way around; but I was natively a C++ programmer.

Learning C has been interesting.  I feel now that I have a fairly thorough
understanding of how C works as a language and programming environment, and I
intend to share some of that understanding in this post.  If you're already a C
old-timer, then there is nothing new here for you.

# Translation Units
It took me a long time to understand what a "translation unit" is in C, but
understanding this concept gives you almost total control over data visibility
in the language.  It wasn't until I built my own C parser that I had any real
kind of understanding.  I will summarize it here as:

> A translation unit is the collection of source files that gets compiled into a
  single object file.

I'm not going to expand on that definition here, so I hope it is clear enough.

# Data Visibility
Everything about data visibility in C is tied to the concept of a translation
unit, and is thus impacted by the build system.
C has no concept of modules, instead we get keywords and forward declarations.
Here's an example:

    //-- FILE: vector2.h
    struct vector2; // Forward declaration of vector type.

    float
    Vector2CrossProduct(struct vector2 *a, struct vector2 *b);

    struct vector2 *
    Vector2Init(float x, float y);


    //-- FILE: vector2.c
    struct vector2 {
        float x;
        float y;
    };

    struct vector2 *Vector2Init(float x, float y) {
        struct vector2 *vec = (struct vector2 *)malloc(sizeof(struct vector2));
        vec.x = x;
        vec.y = y;
        return vec;
    }

    float Vector2CrossProduct(struct vector2 *a, struct vector2 *b) {
        return a->x * b->y - a->y * b->x;
    }

    void Debug(struct vector2 *vec) {
        printf("vector2{ x:%f, y:%f }", vec->x, vec->y);
    }


    //-- FILE: main.c
    #include "vector2.h"

    struct vector2 *a = Vector2Init(1, 1);
    struct vector2 *b = Vector2Init(2, 2);
    float cross_product = Vector2CrossProduct(a, b);

In production code I wouldn't construct this code this way as we gain nothing by
passing pointers instead of values on the stack.  However, it clearly
illustrates how data visibility works.

In file vector2.h we forward declare the vector2 type and the public functions
that make up its interface. Typical client usage is illustrated by file main.c
where we include the header file.  It's important to note here that main.c
doesn't know the internal structure of a vector2 and can't access any of
vector2's attributes.

In addition to this, Debug() is defined within the translation unit for file
vector2.c and is invisible to main.c. (There is a way around this, but let's
ignore that for now.)

This construction is very nice, I find.  In C you share code by including the
public headers in your translation unit, then linking against the object files
for the final executable.  By using the above structure we can hide the
implementation details of a given datatype while providing an interface for
interacting with it.  Furthermore, we can strictly limit the number of included
headers in our own header files because we just forward declare any datatypes we
need.  I make one exception for this rule and allow inclusion of stdint.h for
better precision numerical datatypes.

This approach keeps compilation relatively fast - a common problem with C++
code.

# Breaking Data Hiding Then Fixing It Again
In the previous code sample I mentioned that there's a way to make Debug()
visible to main.c.  The secret here is with the keyword 'extern'.  If we do a
forward declaration of Debug() in main.c with an extern keyword, then main.c can
call Debug() without issue:

    //-- FILE: main.c
    #include "vector2.h"

    extern void Debug(struct vector2 *vec); // New code

    struct vector2 *a = Vector2Init(1, 1);
    struct vector2 *b = Vector2Init(2, 2);
    float cross_product = Vector2CrossProduct(a, b);

    Debug(a); // New code
    Debug(b); // New code

'extern' is a way to tell the compiler to defer finding a definition until
linkage occurs.  We can use this on functions and data.  But, there's another
way around this to enforce data privacy! It's via the 'static' keyword.

    //-- FILE: vector2.c

    static void Debug(struct vector2 *vec) {
        printf("vector2{ x:%f, y:%f }", vec->x, vec->y);
    }

When we change the definition of Debug() like this, main.c no longer has the
ability to access this function.  Just like with 'extern', 'static' can affect
data and functions.

# Aside: Unity Builds
I'm a big fan of Casey Muratori, and if you follow him you may have heard of the
term "unity build."  What is a unity build?  In short, a unity build is
construction of your source code and build configuration to generate a single
translation unit.

What does this have to do with data hiding?

As I stated above - data hiding in C has everything to do with translation
units.  By collapsing our codebase into a single translation unit, we lose the
use of 'extern' and 'static' as mechanisms for controlling data visibility.  For
this reason alone I'm not personally a fan of using a unity build, but I harbour
no resentment towards the approach.  Sean Barrett has developed the stb
libraries using this approach - even going so far as to include everything in a
single header file; and it makes perfect sense for what he's trying to
accomplish.  As with all things; use the right tools for the job.
