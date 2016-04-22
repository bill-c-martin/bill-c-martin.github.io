---
layout: blog_post
title: The Simplicity of SQLite
category: blog
---

SQLite consists of a single file as the database and a set of CLI commands. "Like all magnificent things, it's very simple."

I first shook hands with SQLite whilst building stuff in Ruby on Rails. At first, I wondered how this fabled database ran, and how I could connect to it, but didn't press the issue because it just worked. Rails' "Convention Over Configuration" metholodology resulted in me having a clear picture of the database in my head already.

Then along came the need to actually see some data. I downloaded [sqliteman](http://sqliteman.yarpen.cz/) thinking I just need some GUI to connect to some localhost server, as my usual workflow demanded.

Upon trying to use it though, I eventually discovered that the database was not a client-server setup. It was, in fact, powered through some flat file under ```db/``` inside the project itself. I opened it with sqliteman and everything just worked.

Several months later, I had the distinct feeling that a GUI was too much for something that felt as minimal as SQLite. All of my data is just sitting right there in that file, after all.

It was then that I discovered something was already available from the command line for me from the start. That something was ```sqlite3``` itself. After using it for an hour the other night, I am happy to say that it is part of my Rails workflow now.

### Rails Example

From inside a Rails project, open the sqlite database inside the db/ folder:

```sh
cd db/
sqlite3 development.sqlite3
```

This results in a ```sqlite>``` prompt.

### Pretty Output

By default, ```SELECT``` queries will show a jumbled mess of data, which especially sucks for ```select *``` queries that are pulling back a lot of columns. Enable a prettier, more readable display with:

```sh
sqlite>.header on
sqlite>.mode column
sqlite>.timer on
```

Current options can be verified with:

```
sqlite>.show
```

### Meat and Potatoes Commands

The essential commands for me are:

```sh
sqlite>.show # display sqlite3 commands
sqlite>.tables #list all tables in the database
sqlite>.schema table_name # show schema for some **table_name**
```

To exit ```sqlite3``` and go back to the regular command line:

```
sqlite>.exit
```

And that's all there is to get going with simple, self-contained SQLite.
