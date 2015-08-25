---
layout: post
title: Chef Dependency Management
tags: [programming]
---

At work we've been using Chef to manage systems automation.  It's been a bit of a rough process with only one
devops team member.  Around five months ago I started pitching in.  This served two purposes: test our existing
process and help out with more pressing automation tasks.  It became quite obvious that our use of Chef required a lot
more discipline and structure.  We're not fully there yet, but we're definitely making improvements.

The purpose of this post is to discuss dependency resolution between cookbooks as we encounter it while
using Chef server.

```

    **********************
    *                    *
    *  Local Dev Machine *
    *                    *
    **********************
              *
              *
              *
    **********************       ************************
    *                    *       *                      *
    *     Chef Server    *********      Chef Node       *
    *                    *       *                      *
    **********************       ************************

```

On your local Dev machine you upload your cookbook to the Chef Server.
When you create a new node, the Chef runtime will try to resolve all cookbook dependencies for the Node so
that the Chef run can execute.

We use a great many cookbooks, all of which attempt to explicitly lay out all their dependencies and
pin their versions.  Perhaps I'll write about why we decided to be so explicit in this regard in a later post.
What's happening to us is that Chef Server is trying to resolve the big dependency chain of cookbooks and is
encountering a conflict somewhere.  This manifests as a timeout when trying to resolve dependencies.
Unfortunately, there's no useful output from Chef at this point, so cookbook developers need to manually
investigate dependencies and isolate the conflict.  [There's an open issue related to it](https://tickets.opscode.com/browse/CHEF-3921)
with the [associated code diff](https://github.com/opscode/chef_objects/commit/a3133ced037d1e508ff18723ad9a6f2b94dea1ea).
This change is available in the nightly builds of Chef, but we're using Chef in production and won't be
taking on the risk of running a nightly.  So we'll sit here patiently in the mean time and wait for the change
to roll out into the next release.

So how do you manually investigate dependency conflicts with Chef?

- Attempt a Chef run and get the full cookbook listing.

- Check your local cookbook metadata.rb and write down the versions against matching cookbooks from the above list.
- For all dependencies in metadata.rb, look at their metadata.rb and write down all explicit versions, matching against the above list.

At this point see if there are any conflicts.

- Look at your environment's `cookbook_versions` attribute. `knife environment show ENV -a cookbook_versions`.

See if there are any conflicting versions here based on what you've noted down in previous steps.

That might not show versions for all of your cookbooks.  In that case Chef will try to use whatever is latest.

- For every `latest` version cookbook, look at it's `metadata.rb` and note dependencies - matching with the above list.

Even still, you might not find any issues.  Unfortunately, this is the position I find myself in lately.
I largely suspect our problems stem from our somewhat undisciplined use of Chef.
We're going to look at pinning all versions in our environments.  Currently they get pinned in cookbooks and environments.
Having multiple locations to search to resolve dependencies certainly makes things more complicated than they should be.
