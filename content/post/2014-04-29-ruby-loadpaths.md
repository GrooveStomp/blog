---
layout: post
title: Ruby Loadpath Confusion
tags: [programming, ruby, filesystem, filesystems]
---

The main application at work was developed in Ruby on Rails, with supporting
services written in Java and PHP. We've recently rewritten the PHP service in
Java, but haven't fully deprecated the old PHP code yet.  All of our
applications and services run on Amazon's AWS.

Going forward we will be trying to gut our monolithic app into many services,
and we're using Vert.x as the underlying technology core to do that.
There's a new feature we're building that we'll be deploying on this new
service infrastructure.  We're continuing to use Ruby on the JVM with Vert.x.

A coworker has built a JRuby service on Vert.x to implement this new feature,
and this is complete to the point where specs are now being written.
When launched as a Vert.x application, everything works fine.  When launched
in test mode the application is unable to find all the appropriate paths
to load required libraries.

When I saw the project I immediately noticed the project structure:

    -app_root
    |+config
    |+controllers
    |+lib
    |+models
    |+service_objects
    |-spec
     |-models
      |-my_model_spec.rb
      |...
     |+controllers
     |-spec_helper.rb
    |-init.rb
    |...

Any given spec has this at the top:

```ruby
require 'spec_helper'
```

This was new to me at the time, but
[RSpec modifies `$LOAD_PATH` directly](http://diminishing.org/require-spec-helper/)
so requiring spec_helper is simpler.

In attempt to help the testing suite load all dependencies properly, my
coworker attempted to eagerly load everything. So at the top of `spec_helper`
was:

```ruby
$LOAD_PATH.unshift File.join(File.expand_path(File.dirname(__FILE__), '../'), 'lib/**/*')
```

It's important to note here that modifying `$LOAD_PATH` does not actually
load anything.  What it does is allow Ruby to find files in the directories specified.

Maybe the solution is clear to you now.
In our models, we're trying to `require` files from `lib/`.
The trick is that individual specs are run such that the active directory is
the directory of that spec.  So, in the case of `my_model_spec.rb` the active
directory would be:

```bash
app_root/spec/models
```

Clearly there is no `lib/` directory there.
The modification to `$LOAD_PATH` didn't help because there is still no
`lib/` directory visible.

The solution was to modify `$LOAD_PATH` in this way:

```ruby
$LOAD_PATH.unshift File.join(File.expand_path(File.dirname(__FILE__), '../'))
```

This effectively puts `app_root` onto the `$LOAD_PATH`, so that Ruby will
find `app_root/lib` for all `require` statements.
