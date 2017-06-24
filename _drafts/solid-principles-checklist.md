---
layout: blog_post
title: SOLID Principles Checklist
category: blog
---

With so many soliloquies of SOLID Principles online, ripe with the same old definitions, theoretical verbosity, and yet, the most basic of examples, I've always found it difficult to digest and keep it all in mind while developing.

So I wanted to create a condensed checklist that is wall hang-worthy.

## SOLID Principles Checklist


- SOLID is a means to an end, not an end in itself
- The end is maintainability.
- Keep your SOLID dogmatism in check; Don't over do it.



### Single Responsibility Principle

- Each class does one thing, and does one thing well
- Each method in a class does one thing, and does one thing well
- If a classes' behavior ever changed, it should impact most of its methods
- Aim for short enough methods that can fit on your screen
- Avoid numerous parameters in methods
- SRP dogmatism should not dirty the code with Needless Complexity

### Open Closed Principle


### Liskov Substitution Principle


### Interface Segregation Principle


### Dependency Inversion Principle







SOLID is all about decoupling your code and designing better applications. How? By ultimately coding to an interface, a concept interlaced through all five principles.

### Single Responsibility Principle
#### What Is It?

A class should have only a single job, and a single reason to change.

#### Pitfalls

##### Not Enough Separation of Concerns

- Avoid thinking "yeah, but this is all just a single large task though".
- Don't think in terms of "tasks" or "responsibilities", think in terms of "behaviors", or as Uncle Bob says:
    - Separate behaviors that change at different times for different reasons.
    - Things that change together you keep together.
    - Things that change apart you keep apart.

###### Example:

Let's say you have a `User` data model that:

- Validates user data
- Runs business rules (eg. hashes the password)
- Stores to MySQL

That's kind of just "one large task" though, right? Except, these behaviors will likely change at different times for different reasons:

- Client: "We like your platform, except we want email/phone optional"
- Architect: "We have a new compliance: all passwords must be encrypted"
- DBA: "We're moving sensitive customer data to DB2, with schema changes"

##### Too Much Separation of Concerns

When you take separation of concerns too far and go overboard with abstractions, you introduce Needless Complexity.

The point is to have light weight code that is easy to change in the future, not predicting every potential change up front right now.

###### Example:

Building on the data model from the previous example, let's say we now are using it for a basic CRUD app for a company who has been on MySQL for years.

In this context, if any of these three behaviors ever change at all, they will likely be changing all at the same time together.

For example, adding a new field results in new validations, new business rules, and query updates being applied all together.

In this scenario, these behaviors are all similar enough that SRP is satisfied. Same data model as before, but in a different context.

##### Dead Giveaways of Violation


#### How to Fix

Identify the different behaviors.

eg. Some CTL  checking for security permissions, querying MySQL database, and then formatting output in array

In this case, there's three points where things could change, such as some internal caller might not care about security, maybe the data might come from some different table or DB, or maybe it should be called through web API and needs to return API.

Good example is ORM, persistence is abstracted away from domain objects


