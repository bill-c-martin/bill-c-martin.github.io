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

Good example is ORM, persistence is abstracted away from domain objects


## Open/Close Principle

Functions and classes should be open for extension, closed for modification
Goal: change behavior without modifying original source code
Anticipate future changes, extract that out, solidfy orignal code
Avoids code rot (constantly editing the same code over time with ifs, etc), or afraid to touch code to do regression impact
Modify behavior without having to touch the source
Separate extensible behavior behind an interface, and flip the dependencies

Good Example is Strategy pattern

## Liskov Substitution Principle

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
public function getAll(): array ( return []; );

Using phpstorm helps here by autogeneating, and squiggling method calls that do not adhere to signature, and squiggling phpdocs that do not match the function's parameters, returns, and exceptions.

## Interface Segretation

	"A client should never be forced to implement an interface that it does not use."

	A fat interface breaks the single responsibility principle.
	Giant interfaces can force objects to implement methods they don't care about.

	Instead, break the interface up into granular interfaces that implement a more common interface.

	Gives flexibility to mix and match interface to compose an object, like how Ruby mixins work.

	Think of as inheritence for interfaces.

Dead giveaways:
	When there could be objects that implement an interface, forced to create methods that do nothing or return null



## Depenedency Inversion
