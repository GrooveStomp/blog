---
date:
url:
title: Debugging Texture Mapping
tags: [a, b, c]
---

- Need some example pictures
- Using color to debug
- Final problem was non-generic "generic" swap function truncating from float to int...

- New problem after fixing that one!
- Clipping wasn't working right...
- Turns out I was assigning to wrong attribute. &.w[x] instead of &.tw[x].
  Worked because of union... :-0