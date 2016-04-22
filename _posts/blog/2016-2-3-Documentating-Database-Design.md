---
layout: blog_post
title: Documenting Database Design
category: blog
---

Documenting database design just seems to be one of those things that web developers tend to suck at.

I have some theories as to why:

- draws on writing & design talents, rather than just technical talents
- is usually about the business domain, not the application itself
- can be boring and tedious

If done before coding, it becomes quickly out of date. If done after coding, it probably never gets done at all.

The odds are further stacked against web developers since conventions and techniques for documenting databases rarely gets brought up, ever.

All the focus goes into the relationships, modeling, and queries.

### Garbage In, Garbage Out

The first step to having good documentation is having good database design in the first place.

If there is a convoluted design, expect convoluted documentation. In fact, expect convoluted data models and business logic in the application itself, too.

Be ruthless about:

 - modeling of business domain into tables in a non-technical manner
   - ie. so easy a ~~caveman~~ business person can (mostly) visualize it
 - well-defined tables with a clear, single purpose
 - foreign key relationships enforced on every table
 - consistent table/column naming
 - normalization

### Where the Pristine Runs Afoul

The design always seems to start off solid, but as development progresses, corners get cut, and before you know it, those pristine tables are full of little hacks that were thrown in last minute.

Sometimes it's the removal of no-longer-needed columns, rendering a once-useful table into something no longer needed itself. 

You then end up with this leftover.. thing, that keeps getting populated by the application. It gets even worse when its sole purpose in life becomes holding up foreign key constraints between other tables.

Other times, ultra-specific, awkwardly-named columns get added to an existing table due to convenience, which often turns into an eyebrow raiser for the next developer that has to figure out what the column does, and why it's in that table.

In worst cases, flag or enum-type columns get added to allow rows to have their own state, effectively denormalizing the table.

And somewhere in the spacetime continuum, or perhaps outside of it, the gods weep.

It's these sort of last minute, weird, stupid things that fouls up pristine database design, and makes documentation that more difficult and verbose. To this, I say: always refactor, no matter the risk. 

### What to Document

Moving along, I find those following the most important to document:

- High-level [ER diagram](https://www.google.com/search?q=entity-relationship+diagram&espv=2&biw=1920&bih=992&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjW_N36ht3KAhVHThQKHX27DwgQ_AUIBigB#tbm=isch&q=entity-relationship+diagram+database) showing relationships, primary & foreign keys
- Short descriptions for all tables at the conceptual/business domain level
- Explanations or notes for columns ***only*** if they are not self-evident
- Example Data For Each Column

Sometimes you will be stuck with weird columns or tables that are not self-evident as to what they are for. ***This*** is what should be documented. 

Redundantly documenting anything that is already self-evident adds noise and buries the tasty morsels that readers should be drooling over.

This applies to code, for that matter.

#### Table Descriptions

Expanding on the table descriptions part, provide a summary for each table:

- The kind of object the table represents
- The table's purpose (in brief, conceptual language)
- Foreign key relationships it has with other tables 
  - ie belongs-to and has-a relationships
  - as in: "orders belongs to carts", "orders has a items" 
- Description & gotchas for the columns that are ***not*** self-evident 
- Example of the data expected in each column, for ***all*** columns
  - If acts as an enum (such as a list of possible status), then list all  values

#### Shut up About the Application

I don't believe in going into detail about how the data may power things on the user interface, or what controllers use the data models, and so forth. 

The database design should stand on its own, regardless of what application, services, or views are using it.

#### Diagrams

ER diagrams really helps one to see how everything fits together at a glance. 

If there are a lot of tables, I find that it helps to break up the tables into clusters which share foreign key relationships, rather than provide a single overview that is not even readable.

Always generate ER diagrams, don't even consider making one by hand for a second. For MySQL, there is the free [MySQL Workbench](https://www.mysql.com/products/workbench/).
