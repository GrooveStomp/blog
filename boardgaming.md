---
layout: page
title: Boardgaming
---

[Boardgaming RSS Feed]({{ site.url }}/boardgaming_feed.xml)

Reverse-chronological list of boardgaming posts.

<table>
  <tr>
    <th>Title</th>
    <th>Date</th>
  </tr>

  {% for post in site.tags.boardgames %}
  <tr>
    <td><a href="{{ post.url }}">{{ post.title }}</a></td>
    <td>{{ post.date | date: "%Y-%m-%d" }}</td>
  </tr>
  {% endfor %}
</table>
