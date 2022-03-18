---
layout: blog_post
title: How to Build and Deploy a Node.js, Express, and MySQL API to GCP
category: blog
tags: ["GCP","Architecture","Cloud", "Node.js"]
---

Let's build a Node.js + Express API from scratch, connect Cloud SQL for MySQL, and deploy it all to Google Cloud using gcloud CLI.

The API will consist of some GET endpoints for retrieving warehouse names and zip codes from an imaginary "Acme" company.

This guide is for developers unfamiliar with Google Cloud Platform (GCP), so you'll start simple and small, and connect things one at a time as you need them.

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

<h2>Table of Contents</h2>

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
  - [Setup SQL Connectivity in the Container](#setup-sql-connectivity-in-the-container)
    - [Add Cloud SQL Connection in Container](#add-cloud-sql-connection-in-container)
    - [Store DB Credentials in Secrets Manager](#store-db-credentials-in-secrets-manager)
    - [Add Secret Manager Accessor Role to the Service Account](#add-secret-manager-accessor-role-to-the-service-account)
    - [Redeploy](#redeploy)
- [How Do I Make Changes and Redeploy?](#how-do-i-make-changes-and-redeploy)
- [Where Did Everything Deploy to in Google Cloud?](#where-did-everything-deploy-to-in-google-cloud)
  - [Cloud Run](#cloud-run)
  - [Cloud Build](#cloud-build)
  - [Artifact Registry](#artifact-registry)
  - [Secrets Manager](#secrets-manager)
  - [IAM & Admin](#iam--admin)
  - [IAM & Admin > Asset Inventory](#iam--admin--asset-inventory)
- [Clean Up](#clean-up)

## Prerequisites

### Use Linux For This

- **Windows Users**: You'll need an actual Linux terminal for this. So, run [Ubuntu in Windows through WSL](https://ubuntu.com/wsl).
- **Linux Users**: This guide is written for Ubuntu.
- **Mac Users**: I'm sure you'll be fine ;)

### Create Google Cloud Platform Account

Head over to [cloud.google.com](https://cloud.google.com/) and create an account if you don't already have one.

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

The full file should look like this:

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
  Make sure git won't let you accidentally commit your MySQL username and password:
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

This endpoint gets an empty `[]` response because there is no warehouse with an ID of 4 in the DB yet.

So add it in the DB through your MySQL GUI client:

```sql
INSERT INTO warehouses VALUES (4, 'Warehouse #4', '12345');
```

Now the endpoint should automatically return that data:

http://localhost:8080/warehouses/4

..because of this dynamic GET routing in `index.js`:

```js
app.route('/warehouses/:id')
  .get( (req, res, next) => {
```

Alright, so now the DB is fully working from localhost.

## Deploy to Google Cloud Using gcloud

Now for the fun part: running all of this from Google Cloud Platform, and accessing the API from the internet.

From the directory where `index.js` etc is, run:

```bash
gcloud run deploy
```

Fill the `gcloud` prompts in as follows:

- **Source code location**: hit `<enter>` so it uses your current project directory
- **Service name**: hit `<enter>` which will default to your directory name `my-node-api`
- **Enable run.googleapis.com?**: `y`
- **Specify a region**: Get from GCP > SQL > 'acme' > Overview > Configuration pane > "Located in" value
- **Enable artifactregistry.googleapis.com?**: `y`
- **Continue?**: `y`
- **Allow unauthenticated?** `y` for now, since this is a demo that will be torn down shortly.

<div class="alert alert-info" role="alert">
  If you get an error about "PERMISSION DENIED: Cloud Build API has not been used in project", go to the link in that error to enable it with a button click. Then rerun the above command.
</div>

If it's successful, you will see something like this:

```bash
Building using Buildpacks and deploying container to Cloud Run service [my-node-api] in project [test-341003] region [us-east1]
✓ Building and deploying... Done.
  ✓ Uploading sources...
  ✓ Building Container... Logs are available at [https://console.cloud.google.com/cloud-build/builds/973b72f5-c556-4600-aae1-f67b79505276?project=584535122189].
  ✓ Creating Revision...
  ✓ Routing traffic...
Done.
Service [my-node-api] revision [my-node-api-00006-luw] has been deployed and is serving 100 percent of traffic.
Service URL: https://my-node-api-h36zeyjqxa-ue.a.run.app
```

Open that "Service URL" in a browser.

<div class="alert alert-info" role="alert">
  <strong>Heads up: DB connectivity does not work yet</strong>
  <p><code>/</code> and <code>/status</code> should work fine</p>
  <p>But <code>/warehouses/</code> and <code>/warehouses/1</code> etc won't work yet. You'll get <code>Service Unavailable</code></p>
  <p>Those require SQL connectivity to be setup still for the container you just deployed.</p>
  <p>We'll get to that shortly.</p>
</div>

So what exactly did `gcloud run deploy` just do?

It did a lot:

1. **Cloud Build** detected your source code language and dependencies
2. **Cloud Build** built a container image based on your source code language and dependencies
3. **Artifact Registry** stored that container image
4. **Cloud Storage** stored your source code
5. **Cloud Run** deployed your new API as a serverless container

We'll dive more into these services and more in a bit.

### Setup SQL Connectivity in the Container

Remember earlier how the API connected to Cloud MySQL just fine from your localhost?

There are a few extra steps to get the deployed container connected too.
#### Add Cloud SQL Connection in Container

Earlier, in `database.js`, there's a line in the code that detects if it's running from the cloud:

```js
// Running from Google Cloud?
if(process.env.NODE_ENV === 'production') {
  console.log('Running from cloud. Connecting to DB through GCP socket.');
  config.socketPath = `/cloudsql/${process.env.INSTANCE_CONNECTION_NAME}`;
}
```

That `/cloudsql/*` socket path is not yet setup within your container.

So set it up:

1. Go to [console.cloud.google.com](https://console.cloud.google.com/) > Cloud Run
2. Click your API
3. Click "Edit & Deploy New Revision"
4. Click the "Connections" tab
5. Click "Add Connection"
   1. Select the database created earlier
   2. And also click the "Enable Cloud SQL Admin API"
6. Click "Deploy"

Step 6 creates a new container revision with these updated settings and deploys it directly from the GCP UI.

#### Store DB Credentials in Secrets Manager

The container also does not currently have DB credentials.

Since you're not storing DB credentials in the codebase (remember earlier `.env` was added to `.gitignore` earlier to prevent it from ever getting committed), and since you should not be passing raw credentials via command line, go ahead and store them in Secrets Manager:

1. Go to [console.cloud.google.com](https://console.cloud.google.com/) > Secrets Manager
2. Create 3 secrets with these names, whose values come from the `.env` file:
   1. `DB_USER`
   2. `DB_PASS`
   3. `DB_NAME`

#### Add Secret Manager Accessor Role to the Service Account

When you ran the `gwp run deploy` command earlier, GCP by default uses a service account as the user.

That service account has all the permissions needed to create and deploy containers (and more).

However, it does not have access to Secrets Manager by default.

1. Go to [console.cloud.google.com](https://console.cloud.google.com/) > IAM & Admin
2. Edit the "Compute Engine default service account"
3. Click "Add Another Role"
4. Select "Secret Manager Secret Accessor" role
5. Save

<div class="alert alert-warning" role="alert">
  For an actual production API, you will want to create a "Developer" or "Deployment Manager" role, attach that role to the user accounts of anyone who can do deployments, and set developers up so their <code>gcloud run deploy</code> command is using <i>their</i> user account and not the default service account.
</div>

#### Redeploy

This step will configure some environment variables in the container which reference the DB connection parameters stored in Secrets Manager, and create a new container revision.

Remember this code from `database.js`?
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

Those `process.env.*` variables are environment variables.

Locally, those come from `.env`.

But when the API runs from the cloud, it comes from environment variables configured in the container.

Let's get those setup.

Copy/paste this command to notepad for now:

```bash
gcloud run services update YOUR_SERVICE_NAME \
--add-cloudsql-instances=YOUR_INSTANCE_CONNECTION_NAME \
--update-env-vars=INSTANCE_CONNECTION_NAME=YOUR_INSTANCE_CONNECTION_NAME \
--update-secrets=DB_USER=DB_USER:latest \
--update-secrets=DB_PASS=DB_PASS:latest \
--update-secrets=DB_NAME=DB_NAME:latest
```

Replace the following fields above (without the `<` and `>` of course):

- `YOUR_SERVICE_NAME`: with your service name from [console.cloud.google.com](https://console.cloud.google.com/) > Cloud Run
- `YOUR_INSTANCE_CONNECTION_NAME`: with the instance connection name from [console.cloud.google.com](https://console.cloud.google.com/) > SQL > "Instance Connection Name" field

Now run the command, with your replacements, in your terminal.

You should see something like this:

```shell
✓ Deploying... Done.
  ✓ Creating Revision...
  ✓ Routing traffic...
Done.
Service [my-node-api] revision [my-node-api-00005-yad] has been deployed and is serving 100 percent of traffic.
Service URL: https://my-node-api-h36zeyjqxa-ue.a.run.app
```

From there, open that "Service URL" in a browser.

Try adding `/status`, `/warehouses`, and `/warehouses/1` to the URL too.

DB connectivity should work now.

If you modify warehouse rows in the DB, and refresh the API URL above, the changes should immediately reflect when calling the API.

Good to go!

## How Do I Make Changes and Redeploy?

When you originally deployed your API to GCP, `gcloud run deploy` stored your code in a compressed archive in Cloud Storage.

This means that your source code needs to be under source control, preferably with tags corresponding to which commits correspond to which API revisions.

Therefore, making code changes to an already-deployed container is a matter of locally modifying your source code and then redeploying again.

So let's add a new `/dummy` endpoint to the existing API and redeploy.

Add this to `index.js`:

```js
app.get('/dummy', (req,res) => res.send('Dummy GET endpoint update'));
```

Run this again:

```bash
gcloud run deploy
```

Fill all the prompts out again, making sure the service name, region etc are the same as before.

<div class="alert alert-info" role="alert">
  In the long run, it would be ideal to setup a <a href="https://cloud.google.com/build/docs/deploying-builds/deploy-cloud-run">build pipeline for continuous deployment</a>, to avoid all those <code>gcloud run deploy</code> prompts
</div>

If successful, you'll see something resembling this again:

```bash
Building using Buildpacks and deploying container to Cloud Run service [my-node-api] in project [test-341003] region [us-east1]
✓ Building and deploying... Done.
  ✓ Uploading sources...
  ✓ Building Container... Logs are available at [https://console.cloud.google.com/cloud-build/builds/973b72f5-c556-4600-aae1-f67b79505276?project=584535122189].
  ✓ Creating Revision...
  ✓ Routing traffic...
Done.
Service [my-node-api] revision [my-node-api-00006-luw] has been deployed and is serving 100 percent of traffic.
Service URL: https://my-node-api-h36zeyjqxa-ue.a.run.app
```

Go to that Service URL in a browser, but append `/dummy`, where you should see the response `Dummy GET endpoint update`.

This new build was similar to the original build, with differences called out here in <i>italics</i>:

1. **Cloud Build** detected your source code language and depedencies, <i>again</i>
2. **Cloud Build** built a <i>new</i> container image based on your source code language and dependencies
3. **Artifact Registry** stored a <i>new copy of this latest</i> container image
4. **Cloud Storage** stored your <i>latest</i> source code <i>in a new archive file</i>
5. **Cloud Run** <i>added a new revision to your existing</i> serverless container


## Where Did Everything Deploy to in Google Cloud?

Let's recap.

When you first ran `gcloud run deploy`:

1. **Cloud Build** detected your source code language and dependencies
2. **Cloud Build** built a container image based on your source code language and dependencies
3. **Artifact Registry** stored that container image
4. **Cloud Storage** stored your source code
5. **Cloud Run** deployed your new API as a serverless container

When you setup SQL connectivity in the container:

1. **Secrets Manager** stored your DB hostname, username, and password securely
2. **IAM & Admin** upgraded your deployment service account with Secrets Manager permissions
3. **Cloud Run** created a new revision to your existing API, and added those Secrets Managers "secrets" as environment variables

Then, when you made that `/dummy` endpoint addition in the code:

1. **Cloud Build** detected your source code language and dependencies again
2. **Cloud Build** built another container image based on your source code language and dependencies
3. **Artifact Registry** stored a brand new copy of this latest container image
4. **Cloud Storage** stored your latest source code in a new archive file
5. **Cloud Run** added a new revision to your existing serverless container

Let's explore these Google Cloud services in more detail.

### Cloud Run

Cloud Run is where your API endpoint lives and is versioned.

When you modify source code and deploy it, a new revision gets created here.

If you also modify non-source code things like connections and environment variables, a new revision still gets created here.

Go to [console.cloud.google.com](https://console.cloud.google.com/) > Cloud Run, where you will see:

- APIs that have been deployed (1 in your case)
- Who deployed them (you)
- Current health status
- Requests per second, over the last hour

Now, click your API service name to drill down further. You will see this information specific to your API:

- Recent performance metrics and errors
- Logs:
  - Build or deploy errors
  - Runtime errors
  - Any `console.error()` or `console.log()` calls from your code would show up here
- Revisions, where you'll see:
  - Initial version deployed by `gcloud run deploy`
  - Subsequent revisions like when DB connectivity and environment variables were added
  - And then yet another revision, when you added the `/dummy` GET endpoint

Now, click through the revisions, and observe the following in the right-side pane:

- Container > Image URL:
  - is the container image that was generated.
  - You'll see that it changes on the revision where you modified your source code with the `/dummy` GET endpoint
- Variables & Secrets:
  - Has nothing defined in your 1st revision
  - But has the DB parameters and SQL instance name defined in later revisions when you added those
- Connections:
  - Has nothing defined in your 1st revision
  - But has the Cloud SQL connection defined in later revisions when you added that

### Cloud Build

Cloud Build is basically the heart of the deployment pipeline.

Every time you made a code change, and ran `gcloud run deploy`, Cloud Build is what detected your language and dependencies, generates a container image for you, stored it in Artifact Registry, and stored your source code in Cloud Storage.

Go to [console.cloud.google.com](https://console.cloud.google.com/) > Cloud Build, where you will see a build history consisting of 2 builds:

- The initial deployment of the API
- The addition of the  `/dummy` GET endpoint

For each build in the history, this screen gives you:

- Direct link to the source code in Cloud Storage
- Commit ID of the source code (we did not use this feature)
- When the build was executed, and for how long.

If you click one of the build IDs, you will see the following build-specific information:

- Build log from end to end
- Link to source code stored in Cloud Storage
- Link to the container image stored in Artifact Registry

### Artifact Registry

Artifact Registry stores the generated Docker container images from running `glcoud run deploy`.

`gcloud run deploy`:

1. Detects the language you are using and its dependencies (from `packages.json` in the case of Node.js)
2. Provisions a Node.js environment for you (on top of a Google-hosted Node.js base container image)
3. Then stores that container image in Artifact Registry

That container image is what powers the serverless environment running your API.

Not only that, but using this container image in Artifacts Registry, you could theoretically spin up:

- Identical localhost running this exact image in a docker container
- Other environments using this docker image (eg dev and stage)

### Secrets Manager

Secrets Manager is a secure storage system for sensitive things.

Remember when we added `.env` to the `.gitignore`?

If you instead stored the credentials directly in your source control (in `.env`), anyone who ever cloned that code would always have your credentials.

Imagine if you also had 20 other APIs using this same DB.

With Secrets Manager, you have a secure, centralized location to store credentials, and only 1 place to update when those credentials change.

### IAM & Admin

This area shows user accounts and service accounts.

If you go to IAM & Admin, you'll see this list.

`Compute Engine default service account` was created for you when you ran `gcloud run deploy`. This is also the one you added the `Secrets Manager Secret Accessor` role to.

You will also see build service account roles here.
  
### IAM & Admin > Asset Inventory

This area is quite unique.

It shows a snapshot of <i>all</i> resources you ended up using as part of this API build and deployment, with direct links to them.

In addition to everything mentioned previously (Cloud Build, Run, Artifact Registry, etc), you will also see resources for:

- Routes
- Subnetworks
- Firewalls
- Pubsubs
- Logging

These were transparently setup for you in that `gcloud run deploy` command.

Behold the PaaS power of Google Cloud Platform!

## Clean Up

Let's delete everything to avoid billing.

GCP makes this surprisingly simple.

1. Go to [console.cloud.google.com](https://console.cloud.google.com/) > IAM & Admin > Manage Resources
2. Click the project you created at the start of this whole process
3. Delete it

Deleting the project for this API will permanently delete all resources used, including the MySQL DB, and prevent any further billing.

Confirm this by going to Artifacts Registry, Cloud Run, Cloud Build, Cloud SQL etc.

You will see a message confirming the resources no longer permit access.
