---
layout: blog_post
title: How to Build and Deploy a Node.js API on Google Cloud
category: blog
---

Build a serverless Node.js + Express.js API from scratch

deploy it to Google Cloud Platform using gcloud CLI.

DB = Firestore, or Datastore.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Setup gcloud CLI](#setup-gcloud-cli)
- [Create a DB in Google Cloud](#create-a-db-in-google-cloud)
  - [Connect to the DB with a Client](#connect-to-the-db-with-a-client)
  - [Create a table and data](#create-a-table-and-data)
- [Setup Node.js and Express.js Locally](#setup-nodejs-and-expressjs-locally)
- [Create an API](#create-an-api)
  - [Initialize](#initialize)
  - [Add MySQL Connectivity](#add-mysql-connectivity)
  - [Add API Routes that Connect to the DB](#add-api-routes-that-connect-to-the-db)
  - [Add a Few More Records](#add-a-few-more-records)
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

## Setup gcloud CLI

1. [Install gcloud](https://cloud.google.com/sdk/docs/install)
2. Run `gcloud init`

## Create a DB in Google Cloud

On cloud.google.com:

> :warning: **Set a good root password**: the DB will be setup exposed to the whole internet since this is just an exercise. For a real DB, you would setup a VPC and not expose the DB to the internet.

1. Menu > SQL > Create Instance
   1. select all the lowest resources/least expensive stuff in advanced options
   2. Set a good root password, this DB will be exposed to the whole internet..
2. Launch the instance, wait until it's ready
3. Click the instance
   1. **Write down the host public IP for later**
4. Click instance > databases > create database
   1. Name: `locations`
   2. Set it to allow all hosts
   3. **Write down the DB name for later**
5. Click users > create a user
   1. **Write down the user/pass for later**
6. Click Connections > and authorize your own IP
7. Go back to the DB instance itself to get the public IP of the host

### Connect to the DB with a Client

Connect to the new DB with a MySQL client:

- db host (public IP) from earlier
- user from earlier
- pass from earlier
- port: `3306`

### Create a table and data

Create a table and populate it with data:

```sql
CREATE TABLE `warehouses` (
   `id` INT NULL,
   `name` VARCHAR(50) NULL DEFAULT NULL,
   `zip` VARCHAR(10) NULL DEFAULT NULL,
   INDEX `index` (`id`)
)
COLLATE='utf8_general_ci'

INSERT INTO warehouses VALUES
   (1, 'Warehouse #1', '33614'), 
   (2, 'Warehouse #23', '90210'),
   (3, 'Warehouse #103', '03103')
;

SELECT * FROM warehouses;
```

## Setup Node.js and Express.js Locally

From a terminal, install node via nvm on Ubuntu:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

Restart terminal:

```bash
source ~/.bashrc
```

Install node:

```bash
nvm install v16.13.1
```

Check if node works:

```bash
node -v
```

## Create an API

### Initialize

Create some project dir:

```bash
mkdir wc-poc-api && cd wc-poc-api
```

Create a project, hit enter through all the questions:

```bash
npm init
```

Add these to the `package.json` that got generated, which will be needed by `gcloud` later on when deploying to Google Cloud:

```js
 "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "engines": {
    "node": ">= 12.0.0"
  },
```

Pull in Express.js to build APIs with, create an entry point:

```bash
npm install express --save
touch index.js
```

Edit index.js and create a basic Express API that responds to `/` GET:

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

Verify http://localhost:8080 works.

### Add MySQL Connectivity

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

> :warning: Make sure git won't let you accidentally commit your mysql user/pass, stupid:

```bash
echo ".env" > .gitignore
```

Edit `.env` and add the DB connection parameters from earlier up:

```bash
DB_HOST=your.database.ip.address
DB_NAME=your-database-name
DB_USER=your-db-user
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

// Running from Google Cloud?
if(process.env.NODE_ENV === 'production') {
  console.log('Running from cloud. Connecting to DB through GCP socket.');
  config.socketPath = `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`;
}

// Or running from localhost?
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

> :memo: Later on when this code is deployed to the cloud, GCP will send a `NODE_ENV` environment variable set to `production` so your code will know it is running from the cloud, and not a localhost.

### Add API Routes that Connect to the DB

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
    "SELECT * FROM `locations`.`warehouses`",
    (error, results, fields) => {
      if(error) throw error;
      res.json(results);
    }
  );
});

app.route('/warehouses/:id')
  .get( (req, res, next) => {
    connection.query(
      "SELECT * FROM `locations`.`warehouses` WHERE id = ?", req.params.id,
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

Go to these in a browser:

- http://localhost:8080
- http://localhost:8080/status
- http://localhost:8080/warehouses
- http://localhost:8080/warehouses/1
- http://localhost:8080/warehouses/2
- http://localhost:8080/warehouses/3

### Add a Few More Records

Go this in a browser:

http://localhost:8080/warehouses/4

This does not work because there is no warehouse with an ID of 4 in the DB.

So add it in the DB:

```sql
INSERT INTO warehouses VALUES (4, 'Warehouse #4', '12345');
```

Now the endpoint should automatically work:

http://localhost:8080/warehouses/4

Because of this dynamic GET routing in the Node.js code that takes whatever ID is passed in the URL and routes it to the query:

```js
app.route('/warehouses/:id')
  .get( (req, res, next) => {
```

## Deploy to Google Cloud Using gcloud

From the directory where `index.js` etc is, run:

```bash
gcloud run deploy
```

Keep these in mind:

- **Source code location**: hit `<enter>`
- **Service name**: `wc-poc-api`
- **Enable run.googleapis.com?**: `y`
- **Specify a region**: Set to the Location that your DB instance says on [Google Cloud > SQL](https://console.cloud.google.com/sql/instances)
- **Enable artifactregistry.googleapis.com?**: `y`
- **Continue?**: `y`
- **Allow unauthenticated?** `y` for now, since this is a demo that will be torn down shortly.

> :memo: If you get an error about "PERMISSION DENIED: Cloud Build API has not been used in project", then go to the link in the error to enable it with a button click. Then rerun the above command.

If it's successful, you will see something like:

> Service [wc-poc-api] revision [wc-poc-api-00001-qiz] has been deployed and is serving 100 percent of traffic.
>
> Service URL: https://wc-poc-api-gyop4mtb5a-ue.a.run.app

So open the URL, from that success output, in a browser.

> :memo: **DB connectivity does not work yet**: `/` and `/status` will work, but `/warehouses/` and `/warehouses/1` won't work.
>
> Those require SQL connectivity to be setup still for the container, in a later step.

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

>:warning: In the long run, you will want to create a "Developer" or "Deployment Manager" role, attach that role to the user accounts of anyone who can do deployments, and set developers up so their `gcloud run deploy` command is using *their* user account and not the default service account.

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

> Done.
>
> Service [wc-poc-api] revision [wc-poc-api-00006-buw] has been deployed and is serving 100 percent of traffic.
>
> Service URL: https://wc-poc-api-gyop4mtb5a-ue.a.run.app

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

And redundantly fill out the prompts, making sure to type the same service name as before (wc-poc-api), and same region.

> :memo: In the long run, it would be ideal to setup a [build pipeline for continuous deployment](https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run).

## Clean Up

1. Go to GCP > IAM & Admin > Manage Resources.
2. Clicking a project shows all resources used.
3. Deleting your project will delete all resources.

