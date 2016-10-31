#!/usr/bin/env sh

hugo -t groovestomp

# Copy RSS feeds to legacy locations.
cp public/index.xml public/feed.xml
cp public/tags/boardgaming/index.xml public/boardgaming_feed.xml
cp public/tags/programming/index.xml public/programming_feed.xml
sudo cp -r public/* /var/www/blog/
