---
layout: post
title: Documenting Database Design
---

UML generation only if the diagram can fit on a single screen, otherwise it will be too convoluted to be useful.
MySQL Workbench
Break database tables up into logical sections, and focus on generating diagrams for those subsections
(give examples)

I think database tables should mostly be self-explanatory, and try to follow Ruby on Rails ActiveRecord conventions:
(list conventions)

Most important is to explain at the conceptual-level, only providing descriptions in areas that are not self-evident, and providing example data everywhere.

However, sometimes certain tables and columns need to be explained. These are what should be documented. Like commenting, redundantly documenting things about tables that are self-evident already just adds noise and buries the tasty morsels that readers should be drooling over.

That being said, provide a summary for each table:
what table represents
purpose (maybe?)
example data for self-evident attributes
description for atttributes that are not self-evident & examples
FK relationships (belongs to, has a)

I don't believe in going into detail about how the data may power things on the user interface, or what controllers use the data models, and so forth. The database design should stand on its own, regardless of what application and views are using it.

On MySQL
InnoDB for FK relationships


