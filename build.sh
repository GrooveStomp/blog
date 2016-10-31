#!/usr/bin/env bash

hugo -t groovestomp

# Copy RSS feeds to legacy locations.
cp public/index.xml public/feed.xml
cp public/tags/boardgaming/index.xml public/boardgaming_feed.xml
cp public/tags/programming/index.xml public/programming_feed.xml

if [[ "$1" == "release" ]]; then
    sudo cp -r public/* /var/www/blog/
elif [[ "$1" == "test" ]]; then
    sudo cp -r public/* /var/www/blog-test/
fi
