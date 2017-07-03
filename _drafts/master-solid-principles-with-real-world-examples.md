---
layout: blog_post
title: How to Kick Ass at SOLID Principles
category: blog
---

<a name="top"></a>

SOLID is all about decoupling your code and designing better applications. How? By ultimately coding to an interface, a concept interlaced through all five principles.

Each of the five principles below are broken up into:

- What is it?
- Why Adhere to It?
- Common Pitfalls
- Dead Giveaways of Violation
- How to Fix


#### Contents

1. [Single Responsibility Principle](#srp)
2. [Open/Close Principle](#ocp)
3. [Liskov Substitution Principle](#lsp)
4. [Interface Segregation Principle](#isp)
5. [Dependency Inversion Principle](#dip)
5. [Further Reading](#further-reading)

<a class="anchor" name="srp"></a>

## Single Responsibility Principle

### What Is It?

A class should have only a single job, and a single reason to change.

### Why Adhere to It?

The SRP prevents classes from growing into maintenance nightmares by keeping them easy to debug, document, and unit test.

### Common Pitfalls

#### Not Enough Separation of Concerns
{:.no_toc}
Avoid thinking "yeah, but this is all just a single large task though".

Don't think in terms of "tasks" or "responsibilities", think in terms of "behaviors", or as Uncle Bob says:

- Separate behaviors that change at different times for different reasons.
- Things that change together you keep together.
- Things that change apart you keep apart.

##### Example:
{:.no_toc}
Let's say you have a `User` data model that:

- Validates user data (eg. email is valid format)
- Runs business rules (eg. hashes the password)
- Stores to database (eg. MySQL)

That's justified as "one large task" and belongs in one class, right? No. These behaviors will likely change at different times for different reasons:

- Client: "We like your platform, except we want email/phone optional"
- Architect: "We have a new compliance: all passwords must be encrypted"
- DBA: "We're moving sensitive customer data to DB2, with schema changes"

And this is only one model.

Let's say you have 50 models. You're looking at changing these 50 models for a variety of reasons, at different times, likely having a domino effect across your codebase.

#### Too Much Separation of Concerns
{:.no_toc}
When you take separation of concerns too far and go overboard with abstractions, you introduce Needless Complexity.

The point is to have light weight code that is easy to change in the future, not predicting every potential change up front right now.

##### Example - No Intentions for Growth:
{:.no_toc}
Let's revisit the `User` data model from the previous example that:

- Validates user data (eg. email is valid format)
- Runs business rules (eg. hashes the password)
- Stores to database (eg. MySQL)

But, let's say this data model is instead only used for some basic internally-facing CRUD app for a company who has been on MySQL for years, with no future intentions for growth.

In this context, when one of these behaviors change, they will all likely change together, if at all. For example, adding a new field likely will result in all of the following updates happening together:

- New validations
- New business rules
- Query updates

In this scenario, these behaviors are all similar enough that SRP can be considered satisfied. Same data model as before, but in a different context.

### Dead Giveaways of Violation

- Long methods that don't come close to fitting on a single screen
- Methods with a long list of parameters
- God classes with tons of methods
- Classes that print or save themselves
- Classes that control a bunch of other classes
- Classes with lots of dependencies, not simple to instantiate

### How to Fix

Identify the different behaviors.

eg. Some CTL  checking for security permissions, querying MySQL database, and then formatting output in array

In this case, there's three points where things could change, such as some internal caller might not care about security, maybe the data might come from some different table or DB, or maybe it should be called through web API and needs to return API.

Good example is ORM, persistence is abstracted away from domain objects

[Back to top](#top)

<a class="anchor" name="ocp"></a>

## Open/Close Principle

### What Is It?

### Why Adhere to It?

### Common Pitfalls

### Dead Giveaways of Violation

### How to Fix

Methods and classes should be open for extension, closed for modification
Goal: change behavior without modifying original source code
Anticipate future changes, extract that out, solidfy orignal code
Avoids code rot (constantly editing the same code over time with ifs, etc), or afraid to touch code to do regression impact
Modify behavior without having to touch the source
Separate extensible behavior behind an interface, and flip the dependencies

Good Example is Strategy pattern

[Back to top](#top)

<a class="anchor" name="lsp"></a>

## Liskov Substitution Principle

### What Is It?

### Why Adhere to It?

### Common Pitfalls

### Dead Giveaways of Violation

### How to Fix

You should be able to drop in a derived class wherever a base is used, and not have unexpected behavior occur.

Examples are derived class methods that:
throw exceptions that the base does not
have different parameters or return types than the base
have more restrictive parameters than the base
have less restrictive return types than the base

indicators of violation:
code that is checking what type a subclass is (Give view example)
throwing exceptions that base method does not

Copied from laracasts:
Signatures must match
	Parameters
	Returns

derived class preconditions should not be stricter
	If base allows any integer to return, the derived should not enforce only positive integers
derived class postconditions should not be looser
	If base forces a positive integer return, derived should not allow any integer to return

Exception types must match
	Don't throw exceptions that the base method doesn't
	Don't throw different exceptions than what the base method does

PHP 7's type casting helps with signature, return types, etc.
Have rigid phpdoc standards (give example):
public method getAll(): array ( return []; );


Using phpstorm helps here by auto-generating, and squiggling method calls that do not adhere to signature, and squiggling phpdocs that do not match the method's parameters, returns, and exceptions.

[Back to top](#top)

<a class="anchor" name="isp"></a>

## Interface Segregation Principle

### What Is It?

### Why Adhere to It?

### Common Pitfalls

### Dead Giveaways of Violation

### How to Fix

"A client should never be forced to implement an interface that it does not use."

A fat interface breaks the single responsibility principle.
Giant interfaces can force objects to implement methods they don't care about.

Instead, break the interface up into granular interfaces that implement a more common interface.

Gives flexibility to mix and match interface to compose an object, like how Ruby mixins work.

Think of as inheritence for interfaces.

Dead giveaways:


When there could be objects that implement an interface, forced to create methods that do nothing or return null

[Back to top](#top)

<a class="anchor" name="dip"></a>

## Dependency Inversion Principle

### What Is It?

### Why Adhere to It?

### Common Pitfalls

### Dead Giveaways of Violation

### How to Fix


"Depend on abstractions, not on concretions"

Higher level modules should not depend upon low level modules.
Ask if higher level module needs knowledge of the details of how a lower level module implements something.

Goal is to have both high and low level modules all depending on an interface.

Great example is a data model method requiring a MySQL connection be passed in. This forces higher level modules to "know" about the DM's inner MySQL connection. It should instead require an interface.

[Back to top](#top)

<a class="anchor" name="further-reading">

## Further Reading

The richest resources I've come across for learning about SOLID Principles are:

### Sites

- ["The SOLID Principles"](https://code.tutsplus.com/series/the-solid-principles--cms-634) learning guide on tutsplus
- The ["SOLID Principles in PHP"](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjau6r2jezUAhVHcj4KHXXvAeAQFggoMAA&url=https%3A%2F%2Flaracasts.com%2Fseries%2Fsolid-principles-in-php&usg=AFQjCNHU05djL8alb4DvBcQdpiSp4tdq3g) course on Laracasts

### Free Books

- [Pablo's SOLID Software Development](http://lostechies.com/wp-content/uploads/2011/03/pablos_solid_ebook.pdf) PDF
- Taylor Otwell's [Laravel: From Apprentice To Artisan](http://fliphtml5.com/wuxi/iemd) book

### Code Examples

- The [Laravel Framework's codebase](https://github.com/laravel/laravel) itself, look no further

[Back to top](#top)