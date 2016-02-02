---
layout: default
title: Documenting Database Design
category: blog
---

Documenting database design just seems to be one of those things that web developers tend to suck at.

Perhaps it's because it
- draws more on writing & design talents, rather than our inate technical & abstract talents
- is really about the business domain, not the application
- can be boring and tedious

If done before coding, it becomes quickly out of date. If done after coding, it probably never gets done at all.

On top of these reasons why the odds are stacked against web developers, conventions and techniques for documenting databases rarely gets brought up at all. All the focus goes into the relationships, modeling, and queries.

# Design them properly in the first place

I think database tables should mostly be self-explanatory, and try to follow Ruby on Rails ActiveRecord conventions:
(list conventions)

- Focus on the business domain
- Rails conventions
- named after a plural noun (logs, books, quotes, persons, users, etc. )
- Enforce relationships properly with foreign keys

Reading up on normalization.

# Documenting Tables
Most important is to explain at the conceptual-level, only providing descriptions in areas that are not self-evident, and providing example data everywhere.

However, sometimes certain tables and columns need to be explained. These are what should be documented. Like commenting, redundantly documenting things about tables that are self-evident already just adds noise and buries the tasty morsels that readers should be drooling over.

That being said, provide a summary for each table:
- what table represents
- purpose (maybe?)
- example data for self-evident attributes
- description for atttributes that are not self-evident & examples
- FK relationships (belongs to, has a)

I don't believe in going into detail about how the data may power things on the user interface, or what controllers use the data models, and so forth. The database design should stand on its own, regardless of what application, services, or views are using it.

# Diagrams
Not required, per se, but really helps in seeing how everything all fits together.
UML generation only if the diagram can fit on a single screen, otherwise it will be too convoluted to be useful.
MySQL Workbench
Break database tables up into logical sections, and focus on generating diagrams for those subsections
(give examples)
