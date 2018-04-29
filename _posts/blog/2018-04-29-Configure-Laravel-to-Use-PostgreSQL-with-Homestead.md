---
layout: blog_post
title: Configure Laravel to Use PostgreSQL with Homestead
category: blog
---

I was working on a new Laravel app locally with Homestead, using MySQL. I later decided to use PostgreSQL. This took a bit longer than expected. Here is how I did it.

1. [Review Homestead Setup](#review-homestead)
2. [Update Laravel's DB Config](#update-config)
3. [Recreate the Database in PostgreSQL](#recreate-database)
4. [Recreate the Database Tables and Data](#recreate-data)
5. [Optional: Install a PostgreSQL client](#install-client)

<a name="review-homestead"></a>

## Review Homestead Setup

First things first, I already had this app in the works, and was already running it with [Homestead](https://laravel.com/docs/5.6/homestead), and MySQL. I already had data seeded to the database too.

Homestead was setup to run separately from my app's repository. The folders/site config in `Homestead.yaml` looks like this:

```yaml
ip: "192.168.10.10"
memory: 2048
cpus: 1
provider: virtualbox

authorize: ~/.ssh/id_rsa.pub

keys:
    - ~/.ssh/id_rsa

folders:
    - map: ~/projects/laravel-forum
      to: /home/vagrant/projects/laravel-forum
sites:
    - map: forum.local
      to: /home/vagrant/projects/laravel-forum/public

databases:
    - homestead
```

One thing to note here is that, by default, Homestead will forward the default `5432` PostgreSQL port to `54320` on the host machine. This will come in handy later when you try to connect to it with SQL client from the host machine.

<a name="update-config"></a>

## Update Laravel's DB Config

Modify the Laravel project's `/.env` environment file in the project root to use the PostgreSQL instance that's already in the Homestead VM.

Change this:

```yaml
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=forum
DB_USERNAME=homestead
DB_PASSWORD=secret
```

to this:

```yaml
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=forum
DB_USERNAME=homestead
DB_PASSWORD=secret
```

After refreshing the Laravel app in the browser, it will now show a database not found error, proving the configuration change worked.

<a name="recreate-database"></a>

## Recreate the database in PostgreSQL

Since Laravel's database migrations do not handle creation of the actual databases, this step has to be handled manually.

Login to Homestead's virtual machine:

```shell
$ vagrant ssh
```

From inside the VM where PostgreSQL is already setup, login to its command line binary:

```shell
$ psql -U homestead -h localhost
```

That `homestead` username is what was setup in Laravel's `.env` file, but more importantly, that's the default username that comes with Homestead. The default password is `secret`.

A PostgreSQL command line is then displayed where queries and SQL can be run:

```shell
psql (9.5.10)
SSL connection (protocol: TLSv1.2, cipher: ECDHE-RSA-AES256-GCM-SHA384, bits: 256, compression: off)
Type "help" for help.

homestead=#
```

Create the database. In my case, I only had one database called `forum`:

```shell
homestead=# create database forum;
```

After refreshing the Laravel app in the browser again, it will now show some table not found error, proving the database was created successfully.

Type `\q` to logout of psql, and then `exit` to log out of Homestead.

<a name="recreate-data"></a>

## Recreate the Database Tables and Data

With MySQL, I did not manually touch the data directly or with `php artisan tinker`, but instead used migrations and database seeds from the start. The seeds are default Laravel seeder classes that use the built in factories and `faker`.

So all I had to do was rerun the migrations and seeds with:

```shell
$ php artisan migrate:refresh --seed
```

At this point, the Laravel app was again fully functional upon browser refreshing and was now running from PostgreSQL.

<a name="install-client"></a>

## Optional: Install a PostgreSQL client

As nice as the `psql` command line seems, I prefer using a GUI SQL client to quickly view and scan the data. Since I'm on Arch Linux, I was already using TeamSQL as my SQL GUI client.

Although Homestead uses PostgreSQL's default `5432` inside the virtual machine, it forwards to `54320`, which is what has to be used for a SQL GUI client to connect from the host to the PostgreSQL instance inside the VM guest.

The connection info is:

- Host: localhost
- Port: 54320
- Username: homestead
- Password: secret