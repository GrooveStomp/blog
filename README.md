This is the source for my personal blog at https://groovestomp.github.io/

# Dependencies
- [hugo](https://gohugo.io/)

# Building
```
hugo
```
This outputs to the `./public/` directory.

# Testing
```
hugo server
```
Then point a web browser at http://localhost:1313

# Deploying
There are two deploy scripts, both modified from [here](https://gohugo.io/hosting-and-deployment/hosting-on-github/).

One is for SourceHut, and the other is for GitHub.
The GitHub one is legacy, for the old www.groovestomp.com domain where the blog *was* the site.

## Setup
The target github repository for the published content should first be cloned as a git submodule.

    git submodule add -b master <repository> <name>

`<name>` should be either "sourcehut" or "github" as per the `deploy-<name>.sh` script.

## Execute
Actual deployment is then just `./deploy-<name>.sh`.
For GitHub this publishes automatically if you point your domain to <name>.github.io.

For SourceHut this doesn't exist and I have it configured differently anyway.
Just pull the published repo on the server.
