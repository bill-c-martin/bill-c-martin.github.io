---
layout: blog_post
title: The Simplicity of SQLite
category: blog
tags: ["Database"]
---

SQLite consists of a single file as the database and a set of CLI commands. "Like all magnificent things, it's very simple."

I first brushed up against SQLite while building stuff in Ruby on Rails.

The weird thing about SQLite, as a database, is that it's not a client-server setup. It fact, it is just a file.

You literally just open it in something like [sqliteman](https://sourceforge.net/projects/sqliteman/).

Several months after that first encounter though, I had the distinct feeling that a GUI was too much for something that felt as minimal as SQLite. All of my data is just sitting right there in that file, after all.

Introducing: the ```sqlite3``` command.

### Rails Example

From inside a Rails project, open the sqlite database inside the `db/` folder:

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
