---
layout: page
title: All Posts
---

<table>
  <tr>
    <th>Title</th>
    <th>Date</th>
    <th>Tags</th>
  </tr>

  {% for post in site.posts %}
  <tr>
    <td><a href="{{ post.url }}">{{ post.title }}</a></td>
    <td>{{ post.date | date: "%Y-%m-%d" }}</td>
    <td>{{ post.tags | join: ", " }}</td>
  </tr>
  {% endfor %}
</table>
