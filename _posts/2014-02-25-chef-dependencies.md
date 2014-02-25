---
layout: post
title: Chef Dependency Management
---

At work we've been using Chef to manage systems automation.  It's been a bit of a rough process with only one
devops team member.  Around five months ago I started pitching in.  This served two purposes: test our existing
process and help out with more immediate tasks.  It became quite obvious that our use of Chef required a lot
more discipline and structure.  We're not fully there yet, but we're definitely making improvements.

The purpose of this post is to discuss dependency resolution between cookbooks as we encounter it while
using Chef server.
