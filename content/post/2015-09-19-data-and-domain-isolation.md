---
date: 2015-09-19
url: /2015/09/19/data-and-domain-isolation
title: Data and Domain Isolation
tags: [programming]
---

Today I present some scattered thoughts on organizing data and logic in programs.

I'm starting with MVC because it's pervasive and well understood.  As a pattern for wrangling complexity, it's solid because it's so simple: organize your program into three main components and that's how you deal with complexity.  As a bonus, the file organization of your program can just follow the pattern and use three folders.  This simplicity makes it easy for new teammates to understand what's going on.  Because it's so simple, however, MVC has some limitations you encounter pretty quickly.  In the Ruby on Rails community they've come up with Service Objects.  This is really a modification of MVC to what I'll call MVCS.  Instead of three layers, you now get four.  Inevitably MVC winds up stacking a bunch of logic into either the controller layer, or the model layer.  MVCS adds Service Objects as a new layer intended solely to house application logic. In my experience, this additional layer works pretty well in practice.  While it's a simplistic bandaid to the also-simplistic MVC pattern, it does improve understandability in the programs that I've used it with.

Let's talk about data.  Oragizing and modelling data is almost a non-issue in Rails applications, because everybody just uses ActiveRecord and puts all models into the *models/* directory.  That's it; everything lives happily together in a monolithic codebase.  No problem.  But what about *"microservices"*?  By *microservices*, I simply mean a collection of applications (usually smaller, though not necessarily *"micro"* as the name implies) that communicate with each other in place of a single, larger, tightly coupled application.

I am not at all an expert on microservices, but I have some experience working with them.  I've read almost no literature on the topic, so my perspective is most likely naive in that regard.  Before I start talking about data, I will preface that there are many ways to decompose programs into microservices and I've only had experience with one particular direction - decomposing based on application domain.  Follow me on a detour now, while I set up a sample program that we'll talk about in terms of microservices.

### The Detour
Let's use a hypothetical music application as an example.  Let's say our application will allow the user to rip CDs, to purchase music from an online source, to upload music, to search for music and it will also provide a recommenation engine.  If we were going to decompose based on domain, we might end up with separate applications for each of:

- Ripping music from a physical CD and converting to a specified format, then storing to disk.
- Uploading music from local disk to a remote disk.
- Updating a user account (with purchase history) and downloading a remotely stored music file to local disk.
- To forward search queries to a remote source and filter the responses and present them back to the user.
- Periodically searching for artists, albums and labels that seem to "match" the user's interests

Most likely, such an application would have a single front-end interface to present to the end-user.
This is a great starting point.  It seems like we've got some separate domains that are well defined, based on specific functionality.  What implications does this division put on our data model?  Here are some thoughts that come to mind:

- We need some concept of a user.
- We need some concept of purchase history.
- We have local storage.
- We have remote storage.
- We have a remote *source* of information.
- We have a process that runs periodically which performs some analysis on the user's information and performs searches on the remote source.

And some questions that come out of those:

- Do we tie purchase history directly to a user?
- Do we tie remote storage directly to a user?
- Do we allow saving search history?
- Do we allow saving search filters?
- Do we need the concept of an account?

How do we organize our data across these applications?  Purchasing music requires access to user purchase history. Recommending music requires access to the user's existing music collection, which may or may not consist entirely of their purchase history, but probably also would like access to search history and uploads.  Purchasing music should probably take into account music that's already been uploaded by the user.  We should allow the user to download music multiple times and to different machines.

### End Detour
There are two main methods I can visualize for organizing our data.  **Option 1**: Each application can have all of its data local to itself, in an isolated database.  This is optimal for keeping services independent from each other, but incurs costs in terms of replicating data and dealing with stale data.  **Option 2:** We can share all data in a universal database and have each application just grab whatever is needed.  This is great for data normalization and accuracy. If there is complex business logic associated with reading and writing data, though, and that business logic lives outside of the database itself, then we run the risk of misusing the data, or of duplicating business logic across multiple applications.  There are many hybrid approaches that optimize for different needs.  You can have isolated databases that replicate to and from a universal master.  You can have services be restricted to only access data they need.  You can share business logic as library code.  You can even do this latter form in multiple ways that approach language-agnosticism.  It's important to keep in mind that with all of these decisions we're not necessarily reducing complexity, but we're trying to isolate it and improve any of: runtime cost, memory cost, development cost, data archival accuracy or any number of other factors.  Any such decision is always going to be simpler if all the requirements are laid out clearly and prioritized.  This is a situation where it's particularly important not to engage in [architecture astronautism](http://www.joelonsoftware.com/articles/fog0000000018.html) and focus on the constraints that are known, as decisions made here can have unforseen long-term effects that may be difficult to address.

Next time I want to start talking about application communication in a microservice architecture.  Data organization and models can have a large impact on long-term costs associated with developing and maintaining a project.  Decisions about application communication can amplify those costs (or savings).