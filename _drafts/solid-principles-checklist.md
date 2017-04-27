---
layout: blog_post
title: Some Post Title
category: blog
---

// Come up with structure, such as each principle defined, example, and list of dead giveaways of when they're being  violated

## Single Responsibility Principle

A class should have one and only one reason to change
If you compacted code down into psuedo code comments, and read it back. It's easy to say yeah this is all one large task. SRP is more about conducive to change.

The class should have only a single job. 

eg. Some CTL  checking for security permissions, querying MySQL database, and then formatting output in array

In this case, there's three points where things could change, such as some internal caller might not care about security, maybe the data might come from some different table or DB, or maybe it should be called through web API and needs to return API.


## Open/Close Principle

Functions and classes should be open for extension, closed for modification
Goal: change behavior without modifying original source code
Anticipate future changes, extract that out, solidfy orignal code
Avoids code rot (constantly editing the same code over time with ifs, etc), or afraid to touch code to do regression impact
Modify behavior without having to touch the source
Separate extensible behavior behind an interface, and flip the dependencies

## Liskov Substitution Principle

Copied from laracasts:
Signatures must match
Preconditions can't be greater
Post conditions at least equal to
Exception types must match

## Interface Segretation 
## Depenedency Inversion
