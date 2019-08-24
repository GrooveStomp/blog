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
There's a deploy script taken from [here](https://gohugo.io/hosting-and-deployment/hosting-on-github/).
```
./deploy.sh
```
Before running this, [the published blog repository](https://github.com/GrooveStomp/groovestomp.github.io) should be checked out as a git submodule:
```
git submodule add -b master git@github.com:GrooveStomp/groovestomp.github.io.git github
```
The deploy script will output the static site to `./github/`, which is the submodule for the published site; it then pushes to master for that repo, publishing the site.