---
layout: default
title: Documenting Database Design
category: blog
---

Documenting database design just seems to be one of those things that web developers tend to suck at.

I have some theories as to why:

- draws on writing & design talents, rather than just technical talents
- is usually about the business domain, not the application itself
- can be boring and tedious

If done before coding, it becomes quickly out of date. If done after coding, it probably never gets done at all.

On top of these reasons why the odds are stacked against web developers, conventions and techniques for documenting databases rarely gets brought up, ever.

All the focus goes into the relationships, modeling, and queries.

### Garbage In, Garbage Out

It seems to me that the first step to having good documentation is having good database design in the first place.

If you have a convoluted design, expect convoluted documentation. In fact, expect convoluted data models and business logic in the application itself, too.

I try to be ruthless about:

 - modeling of business domain in a non-technical manner
   - ie. so easy a ~~caveman~~ business person can read it
 - well-defined tables with a clear, single purpose
 - foreign key relationships enforced on every table
 - consistent table/column naming
 - normalization

### Where the Pristine Runs Afoul

The design always seems to start off solid, but as development progresses, corners get cut, and before you know it, those pristine tables are full of little hacks that were thrown in last minute.

Sometimes it's the removal of no-longer-needed columns, rendering a once-useful table into something no longer needed itself. 

So you have this leftover.. thing, that keeps getting populated by the application. It's even worse if it holds up foreign key constraints between other tables.

Other times, ultra-specific, awkwardly-named columns get added to an existing table due to convenience, and it's always added late in the development to serve some hacked-together functionality.

In worst cases, flag or enum-type columns get added to allow rows to have their own state, effectively denormalizing the table.

And somewhere in the spacetime continuum, or perhaps outside of it, the gods weep.

It's these sort of last minute, weird, stupid things that fouls up pristine database design, and makes documentation that more difficult and verbose. To this, I say: always refactor, no matter the risk. 

### Documenting Tables
Most important is to explain at the conceptual-level, only providing descriptions in areas that are not self-evident, and providing example data everywhere.

However, sometimes certain tables and columns need to be explained. These are what should be documented. Like commenting, redundantly documenting things about tables that are self-evident already just adds noise and buries the tasty morsels that readers should be drooling over.

That being said, provide a summary for each table:

- what table represents
- purpose (maybe?)
- example data for self-evident attributes
- description for atttributes that are not self-evident & examples
- FK relationships (belongs to, has a)

I don't believe in going into detail about how the data may power things on the user interface, or what controllers use the data models, and so forth. The database design should stand on its own, regardless of what application, services, or views are using it.

### Diagrams
Not required, per se, but really helps in seeing how everything all fits together.
UML generation only if the diagram can fit on a single screen, otherwise it will be too convoluted to be useful.
MySQL Workbench
Break database tables up into logical sections, and focus on generating diagrams for those subsections
(give examples)
