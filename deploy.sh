#!/bin/sh

set -e
printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project
hugo -d github

cd github
git add .

# Commit
msg="Rebuilding site $(date)"
if [ -n "$*" ]; then
    msg = "$*"
fi
git commit -m "$msg"

# Push and build
git push origin master
