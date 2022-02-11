---
layout: blog_post
title: How to Build and Deploy a Node.js, Express, and MySQL API to GCP
category: blog
---

Let's build a Node.js + Express API from scratch, connect it Cloud SQL for MySQL, and deploy it all to Google Cloud using gcloud CLI.

The API will consist of some GET endpoints for retrieving warehouse names and zip codes from an imaginary "Acme" company.

This guide is intended for developers unfamiliar with Google Cloud Platform (GCP), so you'll start simple and small, and connect things one at a time as you need them.

Here's what we'll do:

1. Install Node.js and gcloud CLI locally
2. Create a MySQL DB in Cloud SQL on GCP
3. Connect to it using a DB client, and seed it with some data
4. Create a basic API in Node.js and Express, run it locally
5. Deploy the API to a container on GCP
6. Add MySQL connectivity to the container
7. Store MySQL credentials in GCP Secrets Manager
8. Redeploy, and run the API across the internet
9. Review all the moving parts in GCP
10. Make code changes, and redeploy
11. Kill everything in GCP so you don't get charged

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Prerequisites](#prerequisites)
  - [Use Linux For This](#use-linux-for-this)
  - [Create Google Cloud Platform Account](#create-google-cloud-platform-account)
  - [Setup gcloud CLI](#setup-gcloud-cli)
  - [Setup Node.js and Express.js Locally](#setup-nodejs-and-expressjs-locally)
- [Create and Seed a Database in Google Cloud](#create-and-seed-a-database-in-google-cloud)
  - [Create MySQL Instance](#create-mysql-instance)
  - [Connect to the DB with a Client](#connect-to-the-db-with-a-client)
  - [Create a Table and Seed it With Data](#create-a-table-and-seed-it-with-data)
- [Create an Express API in Node.js](#create-an-express-api-in-nodejs)
  - [Initialize the API](#initialize-the-api)
  - [Add MySQL Connectivity](#add-mysql-connectivity)
  - [Add API Routes that Connect to the DB](#add-api-routes-that-connect-to-the-db)
  - [Add More Data](#add-more-data)
- [Deploy to Google Cloud Using gcloud](#deploy-to-google-cloud-using-gcloud)
  - [What Just Happened?](#what-just-happened)
  - [Setup SQL Connectivity in the Container](#setup-sql-connectivity-in-the-container)
    - [Add SQL Connection in Container](#add-sql-connection-in-container)
    - [Store DB Credentials in Secrets Manager](#store-db-credentials-in-secrets-manager)
    - [Add Secret Manager Accessor Role to the Service Account](#add-secret-manager-accessor-role-to-the-service-account)
    - [Redeploy](#redeploy)
- [Where Did Everything Deploy to in Google Cloud?](#where-did-everything-deploy-to-in-google-cloud)
  - [GCP > Cloud Run](#gcp--cloud-run)
  - [GCP > Cloud Build](#gcp--cloud-build)
  - [GCP > Artifact Registry](#gcp--artifact-registry)
  - [GCP > Secrets Manager](#gcp--secrets-manager)
  - [GCP > IAM & Admin](#gcp--iam--admin)
  - [GCP > IAM & Admin > Asset Inventory](#gcp--iam--admin--asset-inventory)
- [How Do I Make Changes and Redepoy?](#how-do-i-make-changes-and-redepoy)
- [Clean Up](#clean-up)

## Prerequisites

### Use Linux For This

- **Windows Users**: You'll need an actual Linux terminal for this. So, run [Ubuntu in Windows through WSL](https://ubuntu.com/wsl).
- **Linux Users**: This guide is written for Ubuntu.
- **Mac Users**: I'm sure you'll be fine ;)

### Create Google Cloud Platform Account

Head over to [cloud.google.com](https://cloud.google.com/) and create an account, if you don't already have one.

New accounts come with a free $300 in spending credits.

All of the services used in this article are free tier, except Cloud SQL (MySQL). I used up only 82 cents of that $300 for this article.

### Setup gcloud CLI

Fire up the terminal:

1. [Install gcloud](https://cloud.google.com/sdk/docs/install)
2. Run `gcloud init` and follow the prompts to get authorized and configured.
3. See [Google's guide](https://cloud.google.com/sdk/docs/initializing) for additional help.

By the end of this process, you should see something like:

```sh
[compute]
region = us-east1
zone = us-east1-b
[core]
account = user@google.com
disable_usage_reporting = False
project = example-project
```

### Setup Node.js and Express.js Locally

<div class="alert alert-info" role="alert">
  <strong>Mac users</strong>: <a href="https://dev.to/httpjunkie/setup-node-version-manager-nvm-on-mac-m1-7kl">You're on your own</a> for this step.
</div>

Fire up your Ubuntu terminal and run the following:

```bash
# Install NVM (Node Version Manager). Note: v0.38 is the latest version at this time
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# Restart terminal:
source ~/.bashrc

# Install node. This is the latest version at the time of this writing
nvm install v16.13.1

# Verify that node works:
node -v
```

## Create and Seed a Database in Google Cloud

In the following steps, we'll create a MySQL instance, connect to it, and seed it with test data.

Why MySQL? Because it's the [most used](https://insights.stackoverflow.com/survey/2021#databases).

### Create MySQL Instance

Create the MySQL instance:

1. Click GCP > SQL > Create Instance
   1. Choose MySQL
   2. Enable the Compute API if it asks you
   3. Enter the following:
      1. Instance ID: `acme-db`
      2. Password: Click "GENERATE"
      3. Database version: `5.7`
      4. Region: `us-east1`
      5. Zone Availability: `Single zone`
   4. Click "Show Configuration Options":
      1. Storage > Machine Type: `Shared core`
      2. Storage > Storage Type: `SSD`
      3. Storage > Storage Capacity: `10GB`
      4. Backups > Automate backups: uncheck
      5. Backups > Enable point-in-time recovert: uncheck
   5. Click "Create Instance"

<div class="alert alert-warning" role="alert">
  Spinning this up and running it for a short time will cost you a few cents of your free credits. We'll be shutting this (and everything else) down by the end of this article.
</div>

Wait until the instance is ready. ~10 minutes.

Create a user for your API to use:

1. Go to GCP > SQL > `acme` > Users
2. Click "Add User Account":
   1. User: `test`
   2. Password: [Generate a secure password](https://passwordsgenerator.net/). Copy it down for later.
   3. Set it to allow all hosts
3. Click "Add"

Create a database in the MySQL instance:

1. Go to GCP > SQL > `acme` > Databases
2. Click "Create Database"
   1. Name: `acme`
   2. Click "Create"

Authorize your localhost to connect to this Cloud DB:

1. Go to GCP > SQL > `acme` > Connections
2. Click "Add Network"
   1. Name: `me`
   2. Network: [Get your IPv4](https://www.whatismyip.com/), and append `/32` to it. Eg for `12.34.56.78`, enter `12.34.56.78/32`
   3. Click "Done"
3. Click "Save"

### Connect to the DB with a Client

Connect to the new DB with a MySQL GUI client of your choice:

- **Host**: Get from GCP > SQL > `acme` > Overview > Public IP Address
- **User**: `test`
- **Password**: the password you generated a few steps up
- **Port**: `3306`

### Create a Table and Seed it With Data

Run this in the `acme` database from your MySQL GUI client:

```sql
CREATE TABLE `warehouses` (
   `id` INT NULL,
   `name` VARCHAR(50) NULL DEFAULT NULL,
   `zip` VARCHAR(10) NULL DEFAULT NULL,
   INDEX `index` (`id`)
)
COLLATE='utf8_general_ci';

INSERT INTO warehouses VALUES
   (1, 'Warehouse #1', '33614'), 
   (2, 'Warehouse #23', '90210'),
   (3, 'Warehouse #103', '03103')
;

SELECT * FROM warehouses;
```

You should see data:

| id| name           | zip   |
|---|----------------|-------|
| 1 | Warehouse #1   | 33614 |
| 2 | Warehouse #23  | 90210 |
| 3 | Warehouse #103 | 03103 |

## Create an Express API in Node.js

### Initialize the API

Create some project directory:

```bash
mkdir my-node-api && cd my-node-api
```

Initialize a project, hit enter through all the questions:

```bash
npm init
```

Add the start script and node engine to the `package.json` that was generated.

These will be needed by `gcloud` later on when deploying to Google Cloud.

The full file should look like:

```json
{
  "name": "my-node-api",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "engines": {
    "node": ">= 12.0.0"
  },
  "author": "",
  "license": "ISC"
}
```

Pull in the Express framework, and create an entry point:

```bash
npm install express --save
touch index.js
```

Edit `index.js` and create a basic Express API that responds to `/` GET:

```bash
const express = require('express');
const app = express();

app.get('/', (req, res) => res.send('Hello world.'));

app.listen(8080, () => console.log('App is running at: http://localhost:8080'));
```

Boot the app:

```bash
node index.js
```

Verify [http://localhost:8080](http://localhost:8080) works.

### Add MySQL Connectivity

For this step, we'll connect this API to the MySQL DB running on GCP.

Install these packages:

```bash
npm install mysql --save
npm install dotenv --save
npm install body-parser --save
```

Initialize these files:

```bash
touch database.js .env .gitignore
```

<div class="alert alert-warning" role="alert">
  Make sure git won't let you accidentally commit your mysql user/pass:
</div>

```bash
echo ".env" > .gitignore
```

Edit `.env` and add the DB connection parameters from earlier:

```bash
DB_HOST=your.database.ip.address
DB_NAME=acme
DB_USER=test
DB_PASS=your-db-user-password
```

Edit `database.js` and copy/paste this into it:

```js
const mysql = require('mysql');

var config = {
    user: process.env.DB_USER,
    database: process.env.DB_NAME,
    password: process.env.DB_PASS,
};

// Later on when running from Google Cloud, env variables will be passed in container cloud connection config
if(process.env.NODE_ENV === 'production') {
  console.log('Running from cloud. Connecting to DB through GCP socket.');
  config.socketPath = `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`;
}

// When running from localhost, get the config from .env
else {
  console.log('Running from localhost. Connecting to DB directly.');
  config.host = process.env.DB_HOST;
}

let connection = mysql.createConnection(config);

connection.connect(function(err) {
  if (err) {
    console.error('Error connecting: ' + err.stack);
    return;
  }
  console.log('Connected as thread id: ' + connection.threadId);
});

module.exports = connection;
```

### Add API Routes that Connect to the DB

With MySQL now connected, let's rewrite the GET endpoints to retrieve data from the DB.

Edit `index.js`, nuke everything in there, replace with:

```js
require('dotenv').config()

const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const connection = require('./database');

app.get('/', (req,res) => res.send('Try: /status, /warehouses, or /warehouses/2') );

app.get('/status', (req, res) => res.send('Success.') );

app.get('/warehouses', (req, res) => {
  connection.query(
    "SELECT * FROM `acme`.`warehouses`",
    (error, results, fields) => {
      if(error) throw error;
      res.json(results);
    }
  );
});

app.route('/warehouses/:id')
  .get( (req, res, next) => {
    connection.query(
      "SELECT * FROM `acme`.`warehouses` WHERE id = ?", req.params.id,
      (error, results, fields) => {
        if(error) throw error;
        res.json(results);
      }
    );
  });

// Use port 8080 by default, unless configured differently in Google Cloud
const port = process.env.PORT || 8080;
app.listen(port, () => {
   console.log(`App is running at: http://localhost:${port}`);
});
```

Restart the local server:

```bash
node index.js
```

Verify these are returning data in a browser:

- [http://localhost:8080](http://localhost:8080)
- [http://localhost:8080/status](http://localhost:8080/status)
- [http://localhost:8080/warehouses](http://localhost:8080/warehouses)
- [http://localhost:8080/warehouses/1](http://localhost:8080/warehouses/1)
- [http://localhost:8080/warehouses/2](http://localhost:8080/warehouses/2)
- [http://localhost:8080/warehouses/3](http://localhost:8080/warehouses/3)

### Add More Data

Go to this URL in a browser:

- http://localhost:8080/warehouses/4

This endpoint gets an empty `[]` response because there is no warehouse with an ID of 4 in the DB, yet.

So add it in the DB through your MySQL GUI client:

```sql
INSERT INTO warehouses VALUES (4, 'Warehouse #4', '12345');
```

Now the endpoint should automatically work:

http://localhost:8080/warehouses/4

..because of this dynamic GET routing in `index.js`:

```js
app.route('/warehouses/:id')
  .get( (req, res, next) => {
```

Alright, so now the DB is fully working.

## Deploy to Google Cloud Using gcloud

Now for the fun part: running all of this from Google Cloud Platform.

From the directory where `index.js` etc is, run:

```bash
gcloud run deploy
```

!!!!!!!!!!!!!!!!!!!!!!!!! LEFT OFF HERE !!!!!!!!!!!!!!!!!!!!!!!

Keep these in mind:

- **Source code location**: hit `<enter>`
- **Service name**: `my-node-api`
- **Enable run.googleapis.com?**: `y`
- **Specify a region**: Set to the Location that your DB instance says in GCP > SQL > 'acme'
- **Enable artifactregistry.googleapis.com?**: `y`
- **Continue?**: `y`
- **Allow unauthenticated?** `y` for now, since this is a demo that will be torn down shortly.

<div class="alert alert-info" role="alert">
  If you get an error about "PERMISSION DENIED: Cloud Build API has not been used in project", then go to the link in the error to enable it with a button click. Then rerun the above command.
</div>

If it's successful, you will see something like:

```bash
Service [my-node-api] revision [my-node-api-00001-qiz] has been deployed and is serving 100 percent of traffic.

Service URL: https://my-node-api-gyop4mtb5a-ue.a.run.app
```

So open the URL, from that success output, in a browser.

<div class="alert alert-info" role="alert">
  <strong>DB connectivity does not work yet</strong>
  <p><code>/</code> and <code>/status</code> will work, but <code>/warehouses/</code> and <code>/warehouses/1</code> won't work.</p>
  <p>Those require SQL connectivity to be setup still for the container, in a later step.</p>
</div>

### What Just Happened?

`gcloud run deploy` reads your localhost code from the directory you're in, and is able to determine that it is Node.js.

Presumably.. it is reading `package.json` to determine the entrypoint and how to run your code:

```js
"main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```

as well as determine the exact Node.js environment your code needs:

```js
  "engines": {
    "node": ">= 12.0.0"
  },
```

From there, it:

1. Uploads your code (somewhere?)
2. Generates a docker container image
3. Uploads the image to Google Cloud Platform Artifact Registry
4. And finally sets up URL routing, and permissions.

### Setup SQL Connectivity in the Container

The node code connects directly to the cloud DB, locally.

But there are a few extra steps required to get the deployed service/container connected to the cloud DB.

#### Add SQL Connection in Container

Earlier, in `database.js`, there's a line in the code that detects if it's running from the cloud:

```js
// Running from Google Cloud?
if(process.env.NODE_ENV === 'production') {
  console.log('Running from cloud. Connecting to DB through GCP socket.');
  config.socketPath = `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`;
}
```

This step I believe is what sets up that `/cloudsql/*` socket path in your container.

1. Go to https://console.cloud.google.com/ > Cloud Run
2. Click your API
3. Click "Edit & Deploy New Revision"
4. Click the "Connections" tab
5. Click "Add Connection"
   1. Select the database created earlier
   2. And also click the "Enable Cloud SQL Admin API"
6. Click "Deploy"

Step 6 creates a new container revision with these updated settings and deploys it directly from the GCP UI.

#### Store DB Credentials in Secrets Manager

Since you're not storing DB credentials in the codebase (remember `.env` was added to `.gitignore` earlier to prevent it from ever getting committed), and since you should not be passing raw credentials via command line, go ahead and store them in Secrets Manager:

1. Go to https://console.cloud.google.com/ > Secrets Manager
2. Set up 3 secrets with these names, whose values come from the `.env` file:
   1. `DB_USER`
   2. `DB_PASS`
   3. `DB_NAME`

#### Add Secret Manager Accessor Role to the Service Account

When you ran the `gwp run deploy` command earlier, GCP by default uses a service account as the user. That service account has all the permissions needed to create and deploy containers (and more).

It does not have access to Secrets Manager by default.

1. Go to https://console.cloud.google.com/ > IAM & Admin
2. Edit the "Compute Engine default service account"
3. Click "Add Another Role"
4. Select "Secret Manager Secret Accessor" role
5. Save


<div class="alert alert-warning" role="alert">
  In the long run, you will want to create a "Developer" or "Deployment Manager" role, attach that role to the user accounts of anyone who can do deployments, and set developers up so their `gcloud run deploy` command is using *their* user account and not the default service account.
</div>

#### Redeploy

This step will configure some environment variables on the container, which will reference the DB connection parameters stored in Secrets Manager, and create a new container revision.

Remember this code from `database.js`:

```js
var config = {
    user: process.env.DB_USER,
    database: process.env.DB_NAME,
    password: process.env.DB_PASS,
};

// Running from Google Cloud?
if(process.env.NODE_ENV === 'production') {
  console.log('Running from cloud. Connecting to DB through GCP socket.');
  config.socketPath = `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`;
}
```

Those `process.env.SOME_NAME` are environment variables. Locally, those come from `.env`, but when the API runs from teh cloud, it comes from environment variables configured in the service container.

So, copy/paste this command to notepad for now:

```bash
gcloud run services update AAA_SERVICE_NAME \
--add-cloudsql-instances=AAA_INSTANCE_CONNECTION_NAME \
--update-env-vars=INSTANCE_CONNECTION_NAME=AAA_INSTANCE_CONNECTION_NAME \
--update-secrets=DB_USER=DB_USER:latest \
--update-secrets=DB_PASS=DB_PASS:latest \
--update-secrets=DB_NAME=DB_NAME:latest
```

Replace the following:

- **AAA_SERVICE_NAME**: Is your service name from https://console.cloud.google.com/ > Cloud Run
- **AAA_INSTANCE_CONNECTION_NAME**: Is the instance connection name from https://console.cloud.google.com/ > SQL

**Run the command.**

You should see something like:

```shell
Done.

Service [my-node-api] revision [my-node-api-00006-buw] has been deployed and is serving 100 percent of traffic.

Service URL: https://my-node-api-gyop4mtb5a-ue.a.run.app
```

From there, open that service URL in a browser.

Try adding `/status`, `/warehouses`, and `/warehouses/1` to the URL too.

DB connectivity should work now.

If you modify warehouse rows in the DB, and refresh the API URL above, the changes should reflect immediately when calling the API.

## Where Did Everything Deploy to in Google Cloud?

On https://console.cloud.google.com/:

### GCP > Cloud Run

- Shows the API you just deployed, who deployed it
- Shows its current health status and how many requests per second it is getting
- Clicking the service name shows:
  - Recent performance metrics, and recent errors
  - Revisions: Shows the initial version deployed by `gcloud run deploy`, and shows subsequent revisions created from earlier steps, like the several steps involved in adding DB connectivity to the container through environment variables
  - Logs: The logs will show build/deploy errors, and also runtime errors. Since it's a node API, if you `console.error()` or `console.log()` from your code, those will show up here too
  - the image the container was created from
  - And other things like: its URL, authentication, private vs public access, connection dependencies (eg a SQL db)

### GCP > Cloud Build

- `gcloud run deploy` triggered these, which setup and provision a node environment, with built in environment variables + your custom environment variables, and also uploads source code to Cloud Storage
- History: shows logs from it doing your builds, you can see the commands it runs to install npm/node, and publishing the image to Artifact Registry.
  - If you click a build ID > Execution Details > Source, it provides a direct link to your source code hosted on Cloud Build.
  - Clicking the build ID > source shows 1 build version per `gcloud run deploy` attempt done earlier
- Clicking the build ID > source > artifact > Download lets you download and view the code.

### GCP > Artifact Registry

- When you ran `gcloud run deploy`, it magically created a docker image for you containing an OS, the node runtime environment, that one `/cloudsql/*` mount point, etc.
- So `Cloud Run` shows your service, that service is running in a docker container, and that docker container is built using this image in the artifact registry
- You could theoretically spin up a docker container on your localhost running this exact image..
- You could also spin up other environments using this docker image.

### GCP > Secrets Manager

- Is where the DB connection secrets are permanently stored

### GCP > IAM & Admin

- Shows user accounts and service accounts for the project.
- This is where the one service account had a Secrets Manager Accessor role added to it
  
### GCP > IAM & Admin > Asset Inventory

- Shows a snapshot of all resources used, and where, with direct links to them
- eg. the service containers, the Artifacts Registry image, and also some other stuff `gcloud run deploy` setup up for you, such as routing, subnetworks, and firewalls.

## How Do I Make Changes and Redepoy?

First, Stop Typing All the Things in gcloud run deploy

Add this to `index.js`:

```js
app.get('/dummy', (req,res) => res.send('Dummy GET endpoint update'));
```

Run:

```bash
gcloud run deploy
```

And redundantly fill out the prompts, making sure to type the same service name as before (my-node-api), and same region.

<div class="alert alert-info" role="alert">
  In the long run, it would be ideal to setup a <a href="https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run">build pipeline for continuous deployment</a>.
</div>

## Clean Up

1. Go to GCP > IAM & Admin > Manage Resources.
2. Clicking a project shows all resources used.
3. Deleting your project will delete all resources.

