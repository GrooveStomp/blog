---
layout: page
title: Programming
---

Reverse-chronological list of programming posts.

<ul>
{% for post in site.tags.programming %}
    <li><a href="{{ post.url }}">{{ post.title }} - {{ post.date | date: "%Y-%m-%d" }}</a></li>
{% endfor %}
</ul>

<hr/>

What follows is a really rough, high-level outline of topics I want to address.
I may never actually get around to doing this, but I'm keeping it here for now as a reminder.

Various programming concepts.
The plan is to write tutorials covering each of the topics listed here.

# Computer Graphics

- Creating a GUI

- Software Rendering

- 3D Math
 - Vectors
 - Transformations
 - Matrices
 - Quaternions

- Cameras
 - Rigid Follow Camera
 - Delayed Folow Camera
 - Cameras as Objects

- User Interfaces
 - 2D Overlays

# Strongly Typed Code

- Intro to Reading Haskell
 - @bitemyapp's resources
 - Functions
 - Data
 - Typeclasses

- Applications in Ruby
 - Updating Existing Code

# Code Design and Maintenance
- Refactoring
- Data design
- Referential Transparency
- Immutability
- Mutability
- Functional vs. Object Oriented
- Debugging
- Profiling and Optimization
